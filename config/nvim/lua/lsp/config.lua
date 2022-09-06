if not require('utils').validate({ 'null-ls' }, 'lsp.config') then
    return
end

local function bufmap(mapping, callback, bufnr, mode, opts)
    mode = mode or 'n'
    opts = opts or {}

    vim.keymap.set(
        mode,
        mapping,
        callback,
        vim.tbl_deep_extend('force', { noremap = true, silent = true, buffer = bufnr }, opts)
    )
end

local config = nil

local function on_attach(client, bufnr)
    bufmap('gD', vim.lsp.buf.declaration, bufnr)
    bufmap('gd', vim.lsp.buf.definition, bufnr)
    bufmap('K', vim.lsp.buf.hover, bufnr)
    bufmap('gi', vim.lsp.buf.implementation, bufnr)
    bufmap('<C-k>', vim.lsp.buf.signature_help, bufnr)
    bufmap('<leader>rn', vim.lsp.buf.rename, bufnr)
    bufmap('gr', vim.lsp.buf.references, bufnr)
    bufmap('<leader>q', vim.diagnostic.setloclist, bufnr)
    bufmap('[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', bufnr)
    bufmap('gl', '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', bufnr)
    bufmap(']d', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', bufnr)

    vim.api.nvim_create_autocmd('CursorHold', {
        buffer = bufnr,
        callback = function()
            vim.diagnostic.open_float(nil, {
                focusable = false,
                close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
            })
        end,
    })

    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
                hi LspReferenceRead cterm=bold ctermbg=red guibg=Yellow
                hi LspReferenceText cterm=bold ctermbg=red guibg=Yellow
                hi LspReferenceWrite cterm=bold ctermbg=red guibg=Yellow
            ]],
            false
        )
    end

    if client == 'rust_analyzer' then
        local rt = require('rust-tools')

        vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
        vim.keymap.set('n', '<Leader>a', rt.code_action_group.code_action_group, { buffer = bufnr })
    end
end

local handler_options = { border = 'rounded' }

local defaults = {
    lsp = {
        diagnostic = {
            signs = {
                active = {
                    { name = 'DiagnosticSignError', text = '' },
                    { name = 'DiagnosticSignWarn', text = '' },
                    { name = 'DiagnosticSignHint', text = '' },
                    { name = 'DiagnosticSignInfo', text = '' },
                },
            },
            float = {
                focusable = false,
                style = 'minimal',
                border = 'rounded',
                source = 'always',
            },
            virtual_text = true,
            update_in_insert = true,
            underline = true,
            severity_sort = true,
        },
        handlers = {
            options = handler_options,
            hover = vim.lsp.with(vim.lsp.handlers.hover, handler_options),
            signature_help = vim.lsp.with(vim.lsp.handlers.signature_help, handler_options),
        },
    },
    server = {
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        flags = { debounce_text = 150 },
    },
    extensions = {
        mason = {},
        ['mason-lspconfig'] = {
            ensure_installed = {
                'bashls',
                'intelephense',
                'rust_analyzer',
                'sumneko_lua',
            },
        },
    },
}

local M = {}

function M.get_defaults()
    return defaults
end

function M.setup(conf)
    if config ~= nil then
        return config
    end

    config = vim.tbl_deep_extend('force', defaults, conf or {})

    return config
end

return setmetatable(M, {
    __index = function(_, key)
        return config[key] or defaults[key] or nil
    end,
})
