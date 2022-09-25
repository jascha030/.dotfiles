if not require('utils').validate({ 'null-ls' }, 'lsp.config') then
    return
end

local config = nil

local function on_attach(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    local opts = { noremap = true, silent = true }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)

    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)

    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

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

M.options = {}

function M.setup(options)
    M.options = vim.tbl_deep_extend('force', {}, defaults, options or {})
end

function M.extend(options)
    M.options = vim.tbl_deep_extend('force', {}, M.options or defaults, options or {})
end

M.setup()

return M
