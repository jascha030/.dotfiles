return {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
        local builtins = require('null-ls').builtins
        local formatting = builtins.formatting
        local diagnostics = builtins.diagnostics

        require('null-ls').setup({
            sources = {
                formatting.stylua.with({
                    extra_args = { '--config-path', os.getenv('XDG_CONFIG_HOME') .. '/stylua.toml' },
                }),
                diagnostics.eslint,
                diagnostics.zsh,
                builtins.completion.spell,
                diagnostics.twigcs,
                formatting.beautysh,
                formatting.phpcsfixer.with({
                    args = {
                        '--no-interaction',
                        '--quiet',
                        '--config=' .. os.getenv('HOME') .. '/.config/.php-cs-fixer.php',
                        'fix',
                        '$FILENAME',
                    },
                }),
            },
        })
    end,
}
