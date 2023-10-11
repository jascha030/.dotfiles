local M = {}

function M.client_capabilities()
    local caps = { vim.lsp.protocol.make_client_capabilities() }

    local ok, cmp = pcall(require, 'cmp_nvim_lsp')
    if ok then
        table.insert(caps, cmp.default_capabilities())
    end

    return vim.tbl_deep_extend('force', unpack(caps), {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = false,
            },
        },
    })
end

local defaults = {
    capabilities = M.client_capabilities(),
    flags = {
        debounce_text = 150,
    },
}

function M.config(config)
    local merge = { {}, vim.deepcopy(defaults) }

    if type(config) == 'table' and not vim.tbl_isempty(config) then
        table.insert(merge, config)
    end

    return vim.tbl_deep_extend('force', table.unpack(merge))
end

local function config_error(server, err, level)
    error('Failed to load config for ' .. server .. ' ' .. err, level)
end

---@param server string LSP server name
---@return table
function M.get_server_config(server)
    local ok, config = pcall(require, 'jascha030.lsp.servers.' .. server)
    if not ok then
        config = {}
    end

    if type(config) == 'function' then
        ok, config = pcall(config)
        if not ok then
            config_error(server, 'Error: ' .. config, 2)
        end

        if type(config) ~= 'table' then
            config_error(server, 'provided callback should be a table, got ' .. type(config) .. ' instead', 2)
        end

        return M.config(config)
    end

    if type(config) ~= 'table' then
        config_error(server, 'a table was expected, got ' .. type(config) .. ' instead', 2)
    end

    return M.config(config)
end

---@param on_attach fun(client, buffer)
---@param group string|nil
function M.lsp_attach(on_attach, group)
    group = group or nil

    local attach = {
        callback = function(args)
            if not (args.data and args.data.client_id) then
                return
            end

            on_attach(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
        end,
    }

    if nil ~= group then
        attach.group = group
        vim.api.nvim_create_augroup(group, {})
    end

    vim.api.nvim_create_autocmd('LspAttach', attach)
end

function M.on_attach(client, buffer)
    if client.server_capabilities.completionProvider then
        vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = buffer })
    end

    vim.notify(client.name, vim.log.levels.DEBUG)

    if client.name == 'phpactor' then
        client.server_capabilities.hoverProvider = false
    end

    require('jascha030.lsp.keymaps').on_attach(client, buffer)
end

function M.virtual_text(opts)
    if type(opts.diagnostics.virtual_text) == 'table' and opts.diagnostics.virtual_text.prefix == 'icons' then
        opts.diagnostics.virtual_text.prefix = vim.fn.has('nvim-0.10') == 0 and '●'
            or function(diagnostic)
                local icons = require('jascha030.config.icons').get_diagnostic_signs()

                for d, icon in pairs(icons) do
                    if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                        return icon
                    end
                end
            end
    end
end

-- Setup inlay-hints
function M.inlay_hints(opts)
    local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

    if opts.inlay_hints.enabled and inlay_hint then
        M.lsp_attach(function(client, buffer)
            if client.supports_method('textDocument/inlayHint') then
                inlay_hint(buffer, true)
            end
        end)
    end

    -- Init lsp-inlayhints plugin if available
    local ok, inlay_hints_plugin = pcall(require, 'lsp-inlayhints')
    if not ok then
        return
    end

    M.lsp_attach(inlay_hints_plugin.on_attach, 'LspAttach_inlayhints')
end

local diagnostic_signs_init = function()
    ---@param icon DiagnosticSignIcon
    local function define_diagnostic_icon(icon)
        vim.fn.sign_define(icon.name, {
            text = icon.text,
            texthl = icon.name,
            numhl = icon.name,
        })
    end

    ---@param icon DiagnosticSignIcon
    for _, icon in pairs(require('jascha030.config.icons').get_diagnostic_signs()) do
        define_diagnostic_icon(icon)
    end
end

function M.format(client, bufnr)
    if not client.server_capabilities.documentFormattingProvider then
        return
    end

    vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(c)
            if #require('null-ls.sources').get_available(vim.bo[bufnr].filetype, 'NULL_LS_FORMATTING') > 0 then
                return c.name == 'null-ls'
            end

            return c.name ~= 'null-ls'
        end,
    })
end

function M.signature_help_handler()
    if require('jascha030.utils').has_plugin('noice.nvim') then
        return nil
    end

    return vim.lsp.with(vim.lsp.handlers.signature_help, BORDERS)
end

diagnostic_signs_init()

function M.setup(opts)
    opts = opts or {}

    -- Default on_attach handlers
    M.lsp_attach(M.on_attach)

    -- Init optional features
    M.inlay_hints(opts)
    M.virtual_text(opts)

    -- Configure diagnostics
    local diagnostics = vim.deepcopy(opts.diagnostics)
    vim.diagnostic.config(diagnostics)

    -- LSP Handlers
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { silent = true, border = BORDER })
    vim.lsp.handlers['textDocument/publishDiagnostics'] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, diagnostics)

    local signature_help = M.signature_help_handler()

    if signature_help ~= nil then
        vim.lsp.handlers['textDocument/signatureHelp'] = signature_help
    end
end

return M
