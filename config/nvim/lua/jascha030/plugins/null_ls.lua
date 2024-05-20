---@type LazyPluginSpec
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

local nls = lreq('null-ls')

function M.opts()
    local function fb_conf_path(...)
        local arg = { ... }

        for _, path in ipairs(arg) do
            -- handle potential tables with recursion.
            if type(path) == 'table' then
                local ok, res = pcall(fb_conf_path, path)

                if ok then
                    return res
                end
            end

            if type(path) == 'string' then
                if vim.fn.filereadable(path) == 1 then
                    return path
                end
            end
        end

        error('fb_conf_path (null_ls): No path or fallback paths could be read.')
    end

    local config_dir = os.getenv('XDG_CONFIG_HOME')
    local cwd = vim.fn.getcwd

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
            nls.builtins.formatting.yamlfix,
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
                    fb_conf_path(cwd() .. '/stylua.toml', config_dir .. '/stylua.toml'),
                },
            }),
            nls.builtins.diagnostics.twigcs.with({
                condition = function(utils)
                    return utils.root_has_file('.twig-cs-fixer.php')
                end,
                extra_args = function()
                    return {
                        '--config=' .. cwd() .. '/.twig-cs-fixer.php',
                        'lint',
                        '$FILENAME',
                    }
                end,
            }),
            nls.builtins.formatting.phpcsfixer.with({
                condition = function(utils)
                    if utils.root_has_file({ '.php-cs-fixer.dist.php', '.php-cs-fixer.php' }) then
                        return true
                    end

                    local ok, _ = pcall(fb_conf_path, config_dir .. '/.php-cs-fixer.dist.php')

                    return ok
                end,
                extra_args = function()
                    return {
                        '--no-interaction',
                        '--config=' .. fb_conf_path(
                            cwd() .. '/.php-cs-fixer.dist.php',
                            cwd() .. '/.php-cs-fixer.php',
                            config_dir .. '/.php-cs-fixer.dist.php'
                        ),
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

    nls.register(require('none-ls-shellcheck.diagnostics'))
    nls.register(require('none-ls-shellcheck.code_actions'))
end

return M
