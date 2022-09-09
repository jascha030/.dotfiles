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
        -- disable = { 'zsh' },
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
    ['namespaceUse'] = 'TSNamespaceUse',
})

local parsers = require('nvim-treesitter.parsers')
local ft_to_lang = parsers.ft_to_lang

parsers.ft_to_lang = function(ft)
    return ft == 'zsh' and 'bash' or ft_to_lang(ft)
end
