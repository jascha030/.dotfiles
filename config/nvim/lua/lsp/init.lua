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
        local ok, submod = pcall(require, 'lsp.' .. key)

        return ok and submod or nil
    end,
})

function M.get_server_config(server_name)
    local ok, server_config = pcall(require, 'lsp.config.' .. server_name)

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

    M.keymaps.on_attach(client, buffer)
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

function M.setup(opts)
    opts = opts and vim.tbl_deep_extend('force', M.opts, opts) or {}

    require('lspconfig.ui.windows').default_options.border = BORDER

    M.lsp_attach(require('lsp-inlayhints').on_attach, 'LspAttach_inlayhints')
    M.lsp_attach(M.on_attach)

    if opts.on_attach ~= nil then
        M.lsp_attach(opts.on_attach)
    end

    -- diagnostics
    for name, icon in pairs(require('core.icons').icons.diagnostics) do
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
    end

    vim.diagnostic.config(opts.diagnostics)

    -- handlers
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { silent = true, border = BORDER })
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, BORDERS)
end

return M
