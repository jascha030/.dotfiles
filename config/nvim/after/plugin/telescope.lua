local telescope = require('telescope')
local actions = require('telescope.actions')
local layout = require('telescope.actions.layout')

local extension = telescope.load_extension
local fb_actions = telescope.extensions.file_browser.actions

telescope.setup({
    defaults = {
        set_env = { ['COLORTERM'] = 'truecolor' },
        prompt_prefix = '   ',
        color_devicons = true,
        use_less = true,
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        mappings = {
            n = {
                ['pp'] = layout.toggle_preview,
            },
            i = {
                ['<C-p>'] = layout.toggle_preview,
            },
        },
    },
    pickers = {
        find_files = {
            theme = 'dropdown',
            preview = { hide_on_startup = true },
        },
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

extension('ui-select')
extension('fzy_native')
extension('file_browser')
