local ok, name = require('util').check_deps({ 'lspconfig', 'nvim-lsp-installer', 'null-ls' })
if not ok then
    error('Missing dependency' .. name)
    return
end

require('lsp.installer')
require('lsp.handlers').setup()
require('lsp.null-ls')
