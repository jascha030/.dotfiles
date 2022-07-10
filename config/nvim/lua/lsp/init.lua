local ok, name = require('util').check_deps({ 'lspconfig', 'nvim-lsp-installer', 'null-ls' })
if not ok then
    error('Missing dependency' .. name)
    return
end

local installer = require('lsp.installer')
local handlers = require('lsp.handlers')

local null_ls = require('null-ls')
local fmt = null_ls.builtins.formatting

local config = {
    handlers = { on_attach = handlers.on_attach, capabilities = handlers.capabilities },
    null_ls = {
        sources = {
            fmt.stylua.with({
                extra_args = { '--config-path', os.getenv('HOME') .. '/.config/stylua.toml' },
            }),
            null_ls.builtins.diagnostics.eslint,
            null_ls.builtins.completion.spell,
        },
    },
}

installer.setup(config.handlers)
handlers.setup()
null_ls.setup(config.null_ls)
