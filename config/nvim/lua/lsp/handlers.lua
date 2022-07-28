if not require('util').validate({ 'cmp_nvim_lsp' }) then
    return
end

local M = {}

local cmp_lsp = require('cmp_nvim_lsp')
local keymap = vim.api.nvim_buf_set_keymap
local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
}

local config = {
    signs = signs,
    line = {
        focusable = false,
        close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
    },
    diagnostics = {
        virtual_text = false,
        signs = { active = signs },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = 'minimal',
            border = 'rounded',
            source = 'always',
        },
    },
}

-- Set keymaps conditional on server_capabilities
local function keymaps(bufnr)
    local opts = { noremap = true, silent = true }

    -- TODO: vim.keymap.set('mode', 'map', vim.lsp.buf.{method}, {noremap=true, silent=true, buffer=bufnr})

    keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    keymap(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
    keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
    keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

-- Set auto commands conditional on server_capabilities
local function highlight_document(client)
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
                hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
                hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
                hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
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

function M.show_line_diagnostics()
    vim.diagnostic.open_float(nil, config.lines)
end

function M.setup()
    local hover, help, opts = vim.lsp.handlers.hover, vim.lsp.handlers.signature_help, { border = 'rounded' }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
    end

    vim.diagnostic.config(config.diagnostics)
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(hover, opts)
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(help, opts)
end

function M.on_attach(client, bufnr)
    keymaps(bufnr)
    highlight_document(client)
end

M.capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())


function M.get_server_config(server_name, opts)
    local defaults = { on_attach = M.on_attach, capabilities = M.capabilities, flags = { debounce_text = 150 } }

    opts = opts or defaults

    local ok, settings = pcall(require, 'lsp.config.' .. server_name)
    if ok then
        opts.settings = settings
    end

    return opts
end

return M
