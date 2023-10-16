local M = {
    'nvimtools/none-ls.nvim',
    name = 'null-ls',
}

function M.config()
    local nls = require('null-ls')

    nls.setup({
        sources = {
            nls.builtins.diagnostics.markdownlint,
            nls.builtins.formatting.isort,
            nls.builtins.formatting.black,
            nls.builtins.diagnostics.flake8,
            nls.builtins.diagnostics.eslint,
            nls.builtins.diagnostics.zsh,
            nls.builtins.formatting.blade_formatter,
            nls.builtins.formatting.beautysh,
            nls.builtins.completion.spell,
            nls.builtins.diagnostics.selene.with({
                condition = function(utils)
                    return utils.root_has_file({ 'selene.toml' })
                end,
            }),
            nls.builtins.diagnostics.luacheck.with({
                condition = function(utils)
                    return utils.root_has_file({ '.luacheckrc' })
                end,
            }),
            nls.builtins.diagnostics.twigcs.with({
                condition = function(utils)
                    return utils.root_has_file('.twig-cs-fixer.php')
                end,
                extra_args = function()
                    return {
                        '--config=' .. vim.fn.getcwd() .. '/.twig-cs-fixer.php',
                        'lint',
                        '--fix',
                        '$FILENAME',
                        '--no-cache',
                    }
                end,
            }),
            nls.builtins.formatting.stylua.with({
                extra_args = { '--config-path', os.getenv('XDG_CONFIG_HOME') .. '/stylua.toml' },
            }),
            nls.builtins.formatting.phpcsfixer.with({
                condition = function(utils)
                    return utils.root_has_file('.php-cs-fixer.dist.php')
                end,
                extra_args = function()
                    return {
                        '--quiet',
                        '--no-interaction',
                        '--config=' .. vim.fn.getcwd() .. '/.php-cs-fixer.dist.php',
                        'fix',
                        '$FILENAME',
                    }
                end,
            }),
        },
    })
end

return M
