local nls = lreq('null-ls')

---@type LazyPluginSpec
local M = {
    'nvimtools/none-ls.nvim',
    name = 'null-ls',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvimtools/none-ls-extras.nvim',
        'gbprod/none-ls-php.nvim',
        'gbprod/none-ls-luacheck.nvim',
        'gbprod/none-ls-shellcheck.nvim',
        'gbprod/none-ls-psalm.nvim',
        'gbprod/none-ls-ecs.nvim',
    },
    -- event = { 'BufReadPre', 'BufNewFile' }, -- to enable uncomment this
    -- lazy = true,
}

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
    local code_actions = lreq('null-ls.code-actions')

    -- stylua: ignore start
    return {
        debug = false,
        sources = {
            require('none-ls.code_actions.eslint_d'), -- .with({ condition = function(utils) return utils.root_has_file('node_modules/.bin/eslint') end, }),
            nls.builtins.completion.spell,
            -- Diagnostics
            require('none-ls-luacheck.diagnostics.luacheck').with({
                condition = function(utils)
                    return utils.root_has_file({ '.luacheckrc' })
                end,
            }),
            require('none-ls-psalm.diagnostics').with({
                condition = function(utils)
                    return utils.root_has_file('psalm.xml')
                end,
            }),
            nls.builtins.diagnostics.markdownlint,
            nls.builtins.diagnostics.selene.with({ condition = function(utils) return utils.root_has_file({ 'selene.toml' }) end, }),
            nls.builtins.diagnostics.zsh,
            nls.builtins.diagnostics.twigcs.with({
                condition = function(utils) return utils.root_has_file('.twig-cs-fixer.php') end,
                extra_args = function() return { '--config=' .. cwd() .. '/.twig-cs-fixer.php', 'lint', '$FILENAME' } end,
            }),
            -- Formatting
            require('none-ls.formatting.jq'),
            require('none-ls.formatting.eslint_d').with({
                condition = function(utils)
                    return utils.root_has_file(
                        'node_modules/.bin/eslint')
                end,
            }),
            require('none-ls-ecs.formatting').with({ condition = function(utils) return utils.root_has_file('ecs.php') end, }),
            nls.builtins.formatting.markdownlint,
            nls.builtins.formatting.black,
            nls.builtins.formatting.blade_formatter,
            nls.builtins.formatting.isort,
            nls.builtins.formatting.shellharden,
            nls.builtins.formatting.shfmt.with({ filetypes = { 'sh', 'bash' } }),
            nls.builtins.formatting.yamlfix,
            nls.builtins.formatting.yamlfmt.with({ filetypes = { 'yaml' } }),
            nls.builtins.formatting.stylua.with({ extra_args = { '--config-path', fb_conf_path(cwd() .. '/stylua.toml', config_dir .. '/stylua.toml'), }, }),
            require('none-ls-shellcheck.diagnostics'),
            require('none-ls-shellcheck.code_actions')
        },
    }
    -- stylua: ignore end
end

--
function M.config(_, opts)
    nls.setup(opts)
end

return M
