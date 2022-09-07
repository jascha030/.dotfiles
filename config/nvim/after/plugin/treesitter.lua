require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'bash',
        'comment',
        'css',
        'javascript',
        'json',
        'json5',
        'lua',
        'php',
        'python',
        'markdown',
        'markdown_inline',
        'toml',
        'typescript',
        'vim',
        'yaml',
    },
    indent = { enable = true },
    highlight = {
        enable = true,
        disable = {
            'zsh',
        },
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
})
