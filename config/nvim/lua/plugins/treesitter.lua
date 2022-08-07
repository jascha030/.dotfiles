return function ()
require('nvim-treesitter.configs').setup({
        ensure_installed = {
            'typescript',
            'javascript',
            'python',
            'php',
            'bash',
            'lua',
            'json',
        },
        indent = { enable = true },
        highlight = { enable = true },
        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = nil,
        },
    })
end
