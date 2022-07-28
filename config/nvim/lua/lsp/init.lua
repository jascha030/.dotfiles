if not require('util').validate({ 'lspconfig', 'nvim-lsp-installer', 'null-ls' }) then
    return
end

local lspconfig = require('lspconfig')
local null_ls = require('null-ls')
local handlers = require('lsp.handlers')

require('nvim-lsp-installer').setup({})

for _, servername in ipairs(lspconfig.available_servers()) do
    local server_config = handlers.get_server_config(handlers.defaults, servername)
    
    lspconfig[servername].setup(server_config)
end

handlers.setup()

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua.with({
            extra_args = { '--config-path', os.getenv('HOME') .. '/.config/stylua.toml' },
        }),
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
    },
})
