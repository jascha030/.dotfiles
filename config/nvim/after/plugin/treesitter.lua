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
    indent = {
        enable = true,
    },
    highlight = {
        enable = true,
        disable = { 'zsh' },
        additional_vim_regex_highlighting = true,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000,
    },
    playground = {},
})

require('nvim-treesitter.highlight').set_custom_captures({
    ['className'] = 'TSClassName',
    ['modifier.final'] = 'TSModifierFinal',
    ['scope.relative'] = 'TSScopeRelative',
    ['object.var'] = 'TSMemberObjectVar',
})
