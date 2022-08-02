local ok, null_ls = pcall(require, 'null-ls')
if not ok then
    return
end

local default_servers = {
    'bashls',
    'intelephense',
    'rust_analyzer',
    'sumneko_lua',
}

local stylua_args = {
    '--config-path',
    os.getenv('XDG_CONFIG') .. '/stylua.toml',
}

return {
    ['mason'] = {},
    ['mason-lspconfig'] = {
        ensure_installed = default_servers,
    },
    ['null-ls'] = {
        sources = {
            null_ls.builtins.formatting.stylua.with({ extra_args = stylua_args }),
            null_ls.builtins.diagnostics.eslint,
            null_ls.builtins.completion.spell,
        },
    },
}
