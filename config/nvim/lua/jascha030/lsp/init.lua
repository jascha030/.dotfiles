-- Set default window borders
require('lspconfig.ui.windows').default_options.border = BORDER

local capabilities = vim.lsp.protocol.make_client_capabilities

local M = setmetatable({
    opts = {
        capabilities = (function()
            local caps, ok, cmp = capabilities(), pcall(require, 'cmp_nvim_lsp')

            return ok and cmp.default_capabilities(caps) or caps
        end)(),
        flags = {
            debounce_text = 150,
        },
    },
}, {
    __index = function(_, key)
        local ok, submod = pcall(require, 'jascha030.lsp.' .. key)

        return ok and submod or nil
    end,
})

function M.get_server_config(server_name)
    local ok, server_config = pcall(require, 'jascha030.lsp.config.' .. server_name)

    if ok and type(server_config) == 'table' then
        return vim.tbl_deep_extend('force', M.opts, server_config)
    end

    return vim.tbl_deep_extend('force', {}, M.opts)
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

    if client.name == 'phpactor' then
        client.server_capabilities.hoverProvider = false
    end
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

function M.inlay_hints(opts)
    -- Setup inlay-hints
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
    local diagnostics_icons = require('jascha030.config.icons').get_diagnostic_signs()

    for _, icon in pairs(diagnostics_icons) do
        vim.fn.sign_define(icon.name, { text = icon.text, texthl = icon.name, numhl = '' })
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
        return false
    end

    return vim.lsp.with(vim.lsp.handlers.signature_help, BORDERS)
end

function M.setup(opts)
    opts = opts and vim.tbl_deep_extend('force', M.opts, opts) or {}

    -- Register opts defined handler if available
    if opts.on_attach ~= nil then
        M.lsp_attach(opts.on_attach)
    end

    -- Define diagnostic icons
    diagnostic_signs_init()

    -- Default on_attach handlers
    M.lsp_attach(M.on_attach)
    M.lsp_attach(M.keymaps.on_attach)

    -- Init optional features
    M.inlay_hints(opts)
    M.virtual_text(opts)

    -- Configure diagnostics
    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    -- LSP Handlers
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { silent = true, border = BORDER })
    vim.lsp.handlers['textDocument/signatureHelp'] = M.signature_help_handler()
end

return M
