if not require('util').validate({ 'lspconfig', 'mason', 'mason-lspconfig', 'null-ls' }) then
    return
end

local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lsp = require('mason-lspconfig')
local null_ls = require('null-ls')
local handlers = require('lsp.handlers')


mason.setup({})

mason_lsp.setup({
    ensure_installed = {
        'bashls',
        'html',
        'intelephense',
        'rust_analyzer',
        'sumneko_lua',
    },
})

handlers.setup()

mason_lsp.setup_handlers({
    function(servername)
        lspconfig[servername].setup(handlers.get_server_config(servername))
    end,
})

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua.with({
            extra_args = { '--config-path', os.getenv('XDG_CONFIG') .. '/stylua.toml' },
        }),
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
    },
})
