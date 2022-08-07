if not require('utils').validate({ 'cmp_nvim_lsp' }) then
    return
end

local cmp_lsp = require('cmp_nvim_lsp')

local M = {}

M.signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
}

function M.show_line_diagnostics()
    vim.diagnostic.open_float(nil, {
        focusable = false,
        close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
    })
end

function M.setup()
    local hover, help, opts = vim.lsp.handlers.hover, vim.lsp.handlers.signature_help, { border = 'rounded' }
    for _, sign in ipairs(M.signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
    end

    vim.diagnostic.config({
        virtual_text = true,
        signs = { active = M.signs },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = 'minimal',
            border = 'rounded',
            source = 'always',
        },
    })

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(hover, opts)
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(help, opts)
end

function M.on_attach(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)

    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
                hi LspReferenceRead cterm=bold ctermbg=red guibg=Yellow
                hi LspReferenceText cterm=bold ctermbg=red guibg=Yellow
                hi LspReferenceWrite cterm=bold ctermbg=red guibg=Yellow
                augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold <buffer> lua require('lsp.handlers').show_line_diagnostics()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
            false
        )
    end
end

M.capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

function M.get_server_config(server_name, opts)
    local default = { on_attach = M.on_attach, capabilities = M.capabilities, flags = { debounce_text = 150 } }

    opts = opts or default

    local ok, settings = pcall(require, 'lsp.config.' .. server_name)
    if ok and type(settings) == 'table' then
        opts = vim.tbl_deep_extend('force', opts, settings)
    end

    return opts
end

return M
