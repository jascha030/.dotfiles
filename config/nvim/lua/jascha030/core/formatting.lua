vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
local conform = require('conform')

conform.setup({
    formatters_by_ft = {
        lua = {
            stop_after_first = true,
            'stylua',
        },
        c = {
            stop_after_first = true,
            'uncrustify',
            'clang_format',
        },
        cpp = {
            stop_after_first = true,
            'clang_format',
        },
        cuda = {
            stop_after_first = true,
            'clang_format',
        },
        rust = {
            stop_after_first = true,
            'rustfmt',
        },
        javascript = {
            stop_after_first = true,
            'prettierd',
        },
        typescript = {
            stop_after_first = true,
            'prettierd',
        },
        typescriptreact = {
            stop_after_first = true,
            'prettierd',
        },
        tsx = {
            stop_after_first = true,
            'prettierd',
        },
        css = {
            stop_after_first = true,
            'prettierd',
        },
        scss = {
            stop_after_first = true,
            'stylelint',
            'prettierd',
        },
        html = {
            stop_after_first = true,
            'prettierd',
        },
        markdown = {
            stop_after_first = true,
            'markdownlint',
            'prettierd',
        },
        twig = {
            stop_after_first = true,
            'twig-cs-fixer',
            'prettierd',
        },
        json = {
            stop_after_first = true,
            'prettierd',
            'jq',
        },
        toml = {
            stop_after_first = true,
            'taplo',
            'prettierd',
        },
        jsonc = {
            stop_after_first = true,
            'jq',
            'prettierd',
        },
        proto = {
            stop_after_first = true,
            'buf',
            'protolint',
        },
        nasm = {
            stop_after_first = true,
            'asmfmt',
        },
        asm = {
            stop_after_first = true,
            'asmfmt',
        },
        nix = {
            stop_after_first = true,
            'nixpkgs_fmt',
        },
        yaml = { 'prettierd' },
        php = {
            stop_after_first = true,
            lsp_format = 'first',
            'php_cs_fixer',
        },
    },
    default_format_opts = { lsp_format = 'fallback' },
})

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
        args = { 'fix', '$FILENAME', '--config=' .. vim.fn.expand('$CONFORM_GLOBAL_PCS_FIXER_CONFIG') },
        cwd = util.root_file({ 'composer.json' }),
    }
end
