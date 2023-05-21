return {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
        local nls = require('null-ls')

        nls.setup({
            sources = {
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
                nls.builtins.formatting.stylua.with({
                    extra_args = { '--config-path', os.getenv('XDG_CONFIG_HOME') .. '/stylua.toml' },
                }),
                nls.builtins.diagnostics.eslint,
                nls.builtins.diagnostics.zsh,
                nls.builtins.diagnostics.twigcs,
                nls.builtins.formatting.blade_formatter,
                nls.builtins.formatting.beautysh,
                nls.builtins.formatting.phpcsfixer.with({
                    args = {
                        '--no-interaction',
                        '--quiet',
                        '--config=' .. os.getenv('HOME') .. '/.config/.php-cs-fixer.php',
                        'fix',
                        '$FILENAME',
                    },
                }),
                nls.builtins.completion.spell,
            },
        })
    end,
}
