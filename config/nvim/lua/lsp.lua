if not require('utils').validate({ 'lspconfig', 'mason', 'mason-lspconfig', 'null-ls' }) then
    return
end

local handlers = require('lsp.handlers')
local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lsp = require('mason-lspconfig')
local null_ls = require('null-ls')

local M = {}

local loaded = false

M.lsp_handler = function(servername)
    lspconfig[servername].setup(handlers.get_server_config(servername))
end

function M.setup(opts)
    if loaded then
        return
    end

    loaded = true

    opts = vim.tbl_deep_extend('force', require('lsp.config'), opts or {})

    handlers.setup()
    mason.setup(opts['mason'])
    mason_lsp.setup(opts['mason-lspconfig'])
    null_ls.setup(opts['null-ls'])
    mason_lsp.setup_handlers({ M.lsp_handler })
end

return M
