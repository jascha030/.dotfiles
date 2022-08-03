local M = {}

function M.treesitter()
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

function M.telescope()
    local telescope = require('telescope')
    local extension = telescope.load_extension
    local actions = require('telescope.actions')
    local themes = require('telescope.themes')
    local fb_actions = require('telescope').extensions.file_browser.actions

    telescope.setup({
        ['ui-select'] = { themes.get_dropdown },
        defaults = {
            set_env = { ['COLORTERM'] = 'truecolor' },
            prompt_prefix = ' > ',
            color_devicons = true,
            use_less = true,
            file_sorter = require('telescope.sorters').get_fzy_sorter,
            generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
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

    extension('fzy_native')
    extension('file_browser')
end

function M.hop()
    require('hop').setup({
        keys = 'etovxqpdygfblzhckisuran',
        jump_on_sole_occurrence = false,
    })
end

function M.alpha()
    require('alpha').setup(require('alpha.themes.startify').opts)
end

function M.fidget()
    require('fidget').setup({})
end

function M.color_picker()
    local opts = { noremap = true, silent = true }

    vim.keymap.set('n', '<C-p><C-p>', '<cmd>PickColor<cr>', opts)
    vim.keymap.set('i', '<C-p><C-p>', '<cmd>PickColorInsert<cr>', opts)

    require('color-picker').setup({})
end

return M
