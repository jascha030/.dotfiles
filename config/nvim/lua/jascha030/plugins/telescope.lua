local actions = lreq('telescope.actions')

---@type LazyPluginSpec
local M = {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzy-native.nvim',  build = 'make' },
        { 'nvim-telescope/telescope-ui-select.nvim' },
        { 'nvim-telescope/telescope-file-browser.nvim' },
        { 'nvim-telescope/telescope-fzy-native.nvim' },
        { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    cmd = 'Telescope',
    opts = {
        defaults = {
            set_env = { ['COLORTERM'] = 'truecolor' },
            prompt_prefix = '   ',
            color_devicons = true,
            use_less = true,
            scroll_strategy = 'limit',
            mappings = {
                i = {
                    ["<C-j>"] = {
                        actions.move_selection_next,
                        type = "action",
                        opts = { nowait = true, silent = true }
                    },
                    ['<C-k>'] = {
                        actions.move_selection_previous,
                        type = "action",
                        opts = { nowait = true, silent = true }
                    },
                    ['<C-p>'] = require('telescope.actions.layout').toggle_preview
                },
                n = {
                    ["<C-j>"] = {
                        actions.preview_scrolling_down,
                        type = "action",
                        opts = { nowait = true, silent = true }
                    },
                    ['<C-k>'] = {
                        actions.preview_scrolling_up,
                        type = "action",
                        opts = { nowait = true, silent = true }
                    },
                    ['pp'] = require('telescope.actions.layout').toggle_preview
                    -- ['<C-k>'] = require('telescope.actions').prev,
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
        },
    },
}

function M.config(_, opts)
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local layout = require('telescope.actions.layout')

    local extension = telescope.load_extension
    local fb_actions = telescope.extensions.file_browser.actions

    local extensions = {
        ['ui-select'] = nil,
        ['fzy_native'] = nil,
        ['file_browser'] = {
            mappings = {
                n = {
                    ['q'] = actions.close,
                    ['x'] = actions.delete_buffer,
                    ['d'] = fb_actions.remove,
                },
            },
        },
    }

    for ext, ext_opts in pairs(extensions) do
        opts.extensions[ext] = ext_opts
    end

    opts.defaults.file_sorter = require('telescope.sorters').get_fzy_sorter
    opts.defaults.generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter
    opts.defaults.file_previewer = require('telescope.previewers').vim_buffer_cat.new
    opts.defaults.grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new
    opts.defaults.qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new

    telescope.setup(opts)

    for ext, _ in pairs(extensions) do
        extension(ext)
    end
end

return M
