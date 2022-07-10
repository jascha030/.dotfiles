local ok, name = require('util').check_deps({ 'lspconfig', 'nvim-lsp-installer', 'null-ls' })
if not ok then
    error('Missing dependency' .. name)
    return
end

local installer = require('lsp.installer')
local handlers = require('lsp.handlers')
