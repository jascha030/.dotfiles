if not require('util').validate({ 'lspconfig', 'mason', 'mason-lspconfig', 'null-ls' }) then
    return
end

local loaded = false
local handlers = require('lsp.handlers')
local config = require('lsp.config')

local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lsp = require('mason-lspconfig')
local null_ls = require('null-ls')

local M = {}

M.lsp_handler = function(servername)
    lspconfig[servername].setup(handlers.get_server_config(servername))
end

function M.setup(opts)
    if loaded then
        return
    end

    opts = opts or config

    handlers.setup()
    mason.setup(opts['mason'] or config['mason'])
    mason_lsp.setup(opts['mason-lspconfig'] or config['mason-lspconfig'])

    mason_lsp.setup_handlers({
        M.lsp_handler
    })

    null_ls.setup(opts['null-ls'])

    loaded = true
end

return M
