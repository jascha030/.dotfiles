return {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function(_, opts)
        local nls = require('null-ls')

        vim.list_extend(opts.sources, {
            nls.builtins.diagnostics.markdownlint,
            nls.builtins.diagnostics.selene.with({
                condition = function(utils)
                    return utils.root_has_file({ 'selene.toml' })
                end,
            }),
            nls.builtins.formatting.isort,
            nls.builtins.formatting.black,
            nls.builtins.diagnostics.flake8,
            nls.builtins.diagnostics.luacheck.with({
                condition = function(utils)
                    return utils.root_has_file({ '.luacheckrc' })
                end,
            }),
            nls.formatting.stylua.with({
                extra_args = { '--config-path', os.getenv('XDG_CONFIG_HOME') .. '/stylua.toml' },
            }),
            nls.diagnostics.eslint,
            nls.diagnostics.zsh,
            nls.diagnostics.twigcs,
            nls.formatting.blade_formatter,
            nls.formatting.beautysh,
            nls.formatting.phpcsfixer.with({
                args = {
                    '--no-interaction',
                    '--quiet',
                    '--config=' .. os.getenv('HOME') .. '/.config/.php-cs-fixer.php',
                    'fix',
                    '$FILENAME',
                },
            }),
            nls.builtins.completion.spell,
        })
    end,
}
