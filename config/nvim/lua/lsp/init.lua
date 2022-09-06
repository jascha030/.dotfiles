local utils = require('utils')
if not utils.validate({ 'lspconfig', 'mason', 'mason-lspconfig', 'cmp_nvim_lsp', 'null-ls', 'rust-tools' }, 'lsp') then
    return
end

local loaded = false
local config = nil

local M = {}

function M.setup_lsp(c)
    local conf = c.lsp

    for _, sign in ipairs(conf.diagnostic.signs.active) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
    end

    vim.diagnostic.config(conf.diagnostic)

    vim.lsp.handlers['textDocument/hover'] = conf.handlers.hover
    vim.lsp.handlers['textDocument/signatureHelp'] = conf.handlers.signature_help
end

function M.setup(opts)
    if loaded == true then
        return
    end

    loaded = true

    opts = opts or {}
    config = require('lsp.config').setup(opts)

    M.setup_lsp(config)

    require('lsp.mason').setup(config)
    require('lsp.null_ls').setup()
end

return M
