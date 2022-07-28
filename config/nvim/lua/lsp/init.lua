if not require('util').validate({ 'lspconfig', 'nvim-lsp-installer', 'null-ls' }) then
    return
end

require('nvim-lsp-installer').setup({})

local servers = require('nvim-lsp-installer.servers').get_installed_server_names()
local lspconfig = require('lspconfig')
local null_ls = require('null-ls')
local handlers = require('lsp.handlers')

for _, servername in ipairs(servers) do
    local server_config = handlers.get_server_config(servername)

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
