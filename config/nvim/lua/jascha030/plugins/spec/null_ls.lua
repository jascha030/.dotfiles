local M = {
    'nvimtools/none-ls.nvim',
    name = 'null-ls',
    dependencies = {
        'gbprod/none-ls-php.nvim',
        'gbprod/none-ls-luacheck.nvim',
        'gbprod/none-ls-shellcheck.nvim',
        'nvimtools/none-ls-extras.nvim',
        'gbprod/none-ls-psalm.nvim',
        'gbprod/none-ls-ecs.nvim',
    },
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
            require('none-ls.formatting.jq'),
            require('none-ls.code_actions.eslint'),
            nls.builtins.diagnostics.markdownlint,
            nls.builtins.formatting.isort,
            nls.builtins.formatting.black,
            nls.builtins.formatting.shfmt.with({
                filetypes = { 'sh', 'zsh', 'bash' },
            }),
            nls.builtins.diagnostics.zsh,
            nls.builtins.formatting.blade_formatter,
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
                        '$FILENAME',
                    }
                end,
            }),
            nls.builtins.formatting.phpcsfixer.with({
                condition = function()
                    local ok, _ = pcall(
                        with_fallback,
                        vim.fn.getcwd() .. '/.php-cs-fixer.dist.php',
                        config_dir .. '/.php-cs-fixer.dist.php'
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
        },
    }
end

function M.config(_, opts)
    nls.setup(opts)

    nls.register(require('none-ls-ecs.formatting').with({
        condition = function(utils)
            return utils.root_has_file('ecs.php')
        end,
    }))

    nls.register(require('none-ls-psalm.diagnostics').with({
        condition = function(utils)
            return utils.root_has_file('psalm.xml')
        end,
    }))

    nls.register(require('none-ls-luacheck.diagnostics.luacheck').with({
        condition = function(utils)
            return utils.root_has_file({ '.luacheckrc' })
        end,
    }))

    nls.register(require('none-ls-psalm.diagnostics'))
    nls.register(require('none-ls-shellcheck.diagnostics'))
    nls.register(require('none-ls-shellcheck.code_actions'))
end

return M
