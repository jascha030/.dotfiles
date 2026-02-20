---@type LazyPluginSpec
local M = {
    'stevearc/conform.nvim',
    keys = {
        {
            '<C-l>',
            function()
                require('conform').format()
            end,
            mode = { 'n', 'v' },
            desc = 'Format using conform.',
        },
    },
    opts = {
        formatters_by_ft = {
            ['asm'] = { 'asmfmt' },
            ['bash'] = { 'shfmt_bash' },
            ['c'] = { stop_after_first = true, 'uncrustify', 'clang_format' },
            ['cpp'] = { 'clang_format' },
            ['css'] = { 'prettierd' },
            ['cuda'] = { 'clang_format' },
            ['html'] = { 'prettierd' },
            ['javascript'] = { 'prettierd' },
            ['json'] = { stop_after_first = true, 'prettierd', 'jq' },
            ['jsonc'] = { stop_after_first = true, 'jq', 'prettierd' },
            ['lua'] = { stop_after_first = true, 'stylua' },
            ['markdown'] = { stop_after_first = true, 'markdownlint', 'prettierd' },
            ['nasm'] = { 'asmfmt' },
            ['nix'] = { 'nixpkgs_fmt' },
            ['php'] = { stop_after_first = true, lsp_format = 'first', 'php_cs_fixer' },
            ['proto'] = { stop_after_first = true, 'buf', 'protolint' },
            ['rust'] = { 'rustfmt' },
            ['scss'] = { stop_after_first = true, 'stylelint', 'prettierd' },
            ['sh'] = { 'shfmt_posix' },
            ['swift'] = { 'swift' },
            ['toml'] = { stop_after_first = true, 'taplo', 'prettierd' },
            ['tsx'] = { 'prettierd' },
            ['twig'] = { stop_after_first = true, 'twig-cs-fixer', 'prettierd' },
            ['typescript'] = { 'prettierd' },
            ['typescriptreact'] = { 'prettierd' },
            ['yaml'] = { 'prettierd' },
            ['zsh'] = {},
        },
        formatters = {
            shfmt_bash = { command = 'shfmt' }, -- no -ln flag = default bash
            -- shfmt_zsh = { command = 'shfmt', prepend_args = { '-ln', 'zsh' } },
            shfmt_posix = { command = 'shfmt', prepend_args = { '-ln', 'posix' } },
        },
        default_format_opts = { lsp_format = 'fallback' },
    },
    config = function(_, opts)
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        local conform = require('conform')

        conform.setup(opts)

        conform.formatters.rustfmt = {
            meta = {
                url = 'https://github.com/rust-lang/rustfmt',
                description = 'A tool for formatting rust code according to style guidelines.',
            },
            command = 'rustfmt',
            args = { '--emit=stdout', '--edition=2021' },
        }

        conform.formatters.php_cs_fixer = function()
            local util = require('conform.util')
            return {
                command = util.find_executable({
                    'tools/php-cs-fixer/vendor/bin/php-cs-fixer',
                    'vendor/bin/php-cs-fixer',
                    'vendor-bin/php-cs-fixer/vendor/bin/php-cs-fixer',
                    'tools/php-cs-fixer',
                    'tools/php-cs-fixer.phar',
                    vim.fn.expand('$HOME/.composer/tools/php-cs-fixer/vendor/bin/php-cs-fixer'),
                }, 'php-cs-fixer'),
                stdin = false,
                args = {
                    'fix',
                    '$FILENAME',
                    '--config=' .. vim.fn.expand('$CONFORM_GLOBAL_PCS_FIXER_CONFIG'),
                },
                cwd = util.root_file({ 'composer.json' }),
            }
        end
    end,
}

return M
