local M = {
    'nvimtools/none-ls.nvim',
    name = 'null-ls',
    config = function()
        require('null-ls').register(require('none-ls-php.diagnostics.php'))
    end,
    dependencies = { 'gbprod/none-ls-php.nvim' },
}

local lreq = require('jascha030.lreq')
local nls = lreq('null-ls')

function M.opts()
    local function with_fallback(path, fallback)
        if vim.fn.filereadable(path) == 1 then
            return path
        end

        if vim.fn.filereadable(fallback) ~= 1 then
            error('none-ls: fallback config ' .. fallback .. "doesn't exist.")
        end

        return fallback
    end

    local config_dir = os.getenv('XDG_CONFIG_HOME')

    return {
        sources = {
            nls.builtins.diagnostics.markdownlint,
            nls.builtins.formatting.isort,
            nls.builtins.formatting.black,
            nls.builtins.diagnostics.zsh,
            nls.builtins.formatting.blade_formatter,
            nls.builtins.formatting.beautysh,
            nls.builtins.completion.spell,
            nls.builtins.formatting.shellharden,
            nls.builtins.formatting.yamlfmt.with({ filetypes = { 'yaml' } }),
            nls.builtins.diagnostics.selene.with({
                -- stylua: ignore
                condition = function(utils) return utils.root_has_file({ 'selene.toml' }) end,
            }),
            nls.builtins.formatting.stylua.with({
                extra_args = {
                    '--config-path',
                    with_fallback(vim.fn.getcwd() .. '/stylua.toml', config_dir .. '/stylua.toml'),
                },
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
            nls.builtins.formatting.phpcsfixer.with({
                condition = function()
                    local ok, _ = pcall(
                        with_fallback,
                        vim.fn.getcwd() .. '/.php-cs-fixer.dist.php',
                        config_dir .. '/.php-cs-fixer.php'
                    )
                    return ok
                end,
                extra_args = function()
                    local config =
                        with_fallback(vim.fn.getcwd() .. '/.php-cs-fixer.dist.php', config_dir .. '/.php-cs-fixer.php')
                    return {
                        '--no-interaction',
                        '--config=' .. config,
                        'fix',
                        '$FILENAME',
                    }
                end,
            }),
            -- Deprecatardo
            nls.builtins.diagnostics.eslint.with({
                condition = function(utils)
                    return utils.root_has_file({
                        '.eslintrc.js',
                        '.eslintrc.cjs',
                        '.eslintrc.yaml',
                        '.eslintrc.yml',
                        '.eslintrc.json',
                    })
                end,
            }),
            -- Deprecado massimo
            -- nls.builtins.diagnostics.luacheck.with({
            --     -- stylua: ignore
            --     condition = function(utils) return utils.root_has_file({ '.luacheckrc' }) end,
            -- }),
        },
    }
end

function M.config(_, opts)
    nls.setup(opts)
    nls.register(require('none-ls-php.diagnostics.php'))
end

return M
