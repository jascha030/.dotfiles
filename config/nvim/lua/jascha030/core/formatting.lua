local opts = {
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
            'prettier',
        },
        typescript = {
            stop_after_first = true,
            'prettier',
        },
        typescriptreact = {
            stop_after_first = true,
            'prettier',
        },
        tsx = {
            stop_after_first = true,
            'prettier',
        },
        css = {
            stop_after_first = true,
            'prettier',
        },
        scss = {
            stop_after_first = true,
            'stylelint',
            'prettier',
        },
        html = {
            stop_after_first = true,
            'prettier',
        },
        markdown = {
            stop_after_first = true,
            'markdownlint',
            'prettier',
        },
        twig = {
            stop_after_first = true,
            'twig-cs-fixer',
            'prettier',
        },
        json = {
            stop_after_first = true,
            'jq',
            'prettier',
        },
        toml = {
            stop_after_first = true,
            'taplo',
            'prettier',
        },
        jsonc = {
            stop_after_first = true,
            'jq',
            'prettier',
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
    },
    default_format_opts = {
        lsp_format = 'fallback',
    },
    -- format_on_save = {
    --   timeout_ms = 500,
    --   lsp_fallback = true,
    -- },
    -- format_on_save = function(bufnr)
    --   -- Disable with a global or buffer-local variable
    --   if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
    --     return
    --   end
    --   return { timeout_ms = 500, lsp_fallback = true }
    -- end,
}

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
