local M = {
    'nvimtools/none-ls.nvim',
    name = 'null-ls',
}

local lreq = require('jascha030.lreq')
local nls = lreq('null-ls')

function M.opts()
    return {
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
                -- stylua: ignore 
                condition = function(utils) return utils.root_has_file({ 'selene.toml' }) end,
            }),
            nls.builtins.diagnostics.luacheck.with({
                -- stylua: ignore 
                condition = function(utils) return utils.root_has_file({ '.luacheckrc' }) end,
            }),
            nls.builtins.formatting.stylua.with({
                -- stylua: ignore 
                extra_args = { '--config-path', os.getenv('XDG_CONFIG_HOME') .. '/stylua.toml' },
            }),
            nls.builtins.diagnostics.twigcs.with({
                -- stylua: ignore 
                condition = function(utils) return utils.root_has_file('.twig-cs-fixer.php') end,
                -- stylua: ignore 
                extra_args = function() return { '--config=' .. vim.fn.getcwd() .. '/.twig-cs-fixer.php', 'lint', '--fix', '$FILENAME', '--no-cache' } end,
            }),
            nls.builtins.formatting.phpcsfixer.with({
                -- stylua: ignore 
                condition = function(utils) return utils.root_has_file('.php-cs-fixer.dist.php') end,
                -- stylua: ignore 
                extra_args = function() return { '--quiet', '--no-interaction', '--config=' .. vim.fn.getcwd() .. '/.php-cs-fixer.dist.php', 'fix', '$FILENAME' } end,
            }),
        },
    }
end

function M.config(_, opts)
    nls.setup(opts)
end

return M
