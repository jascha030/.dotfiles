local hop = function()
    require('hop').setup({
        keys = 'etovxqpdygfblzhckisuran',
        jump_on_sole_occurrence = false,
    })
end

local alpha = function()
    require('alpha').setup(require('alpha.themes.startify').opts)
end

local telescope = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local themes = require('telescope.themes')
    local fb_actions = require('telescope').extensions.file_browser.actions

    telescope.setup({
        ['ui-select'] = {
            themes.get_dropdown(),
        },
        defaults = {
            prompt_prefix = ' > ',
            color_devicons = true,
            file_sorter = require('telescope.sorters').get_fzy_sorter,
            generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
            use_less = true,
            set_env = { ['COLORTERM'] = 'truecolor' },
            file_previewer = require('telescope.previewers').vim_buffer_cat.new,
            grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
            qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            },
            file_browser = {
                mappings = {
                    ['n'] = {
                        ['q'] = actions.close,
                        ['x'] = actions.delete_buffer,
                        ['d'] = fb_actions.remove,
                    },
                },
            },
        },
    })

    require('telescope').load_extension('fzy_native')
    require('telescope').load_extension('file_browser')
end

local treesitter = function()
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

return {
    alpha = alpha,
    telescope = telescope,
    treesitter = treesitter,
    hop = hop,
}
