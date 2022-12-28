return {
    { dir = '~/.development/Projects/Lua/nitepal.nvim' },
    'kyazdani42/nvim-web-devicons',
    'yamatsum/nvim-nonicons',
    'nvim-lua/plenary.nvim',
    'noib3/nvim-cokeline',
    'voldikss/vim-floaterm',
    'ojroques/vim-oscyank',
    'hoob3rt/lualine.nvim',
    'kyazdani42/nvim-tree.lua',
    'sheerun/vim-polyglot',
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup({
                filetype_exclude = { 'dashboard' },
            })
        end,
    },
    'f-person/git-blame.nvim',
    'wakatime/vim-wakatime',
    { 'akinsho/toggleterm.nvim', version = '*' },
    {
        'phaazon/hop.nvim',
        branch = 'v2',
        config = function()
            require('hop').setup({
                keys = 'etovxqpdygfblzhckisuran',
                jump_on_sole_occurrence = false,
            })
        end,
    },
    'goolord/alpha-nvim',
    'ziontee113/icon-picker.nvim',
    'gelguy/wilder.nvim',
    'yamatsum/nvim-cursorline',
    {
        'luukvbaal/stabilize.nvim',
        config = true,
    },
    {
        'terrortylor/nvim-comment',
        config = function()
            require('nvim_comment').setup()
        end,
    },
    {
        'petertriho/nvim-scrollbar',
        config = function()
            require('scrollbar').setup({})
        end,
    },
    {
        'folke/which-key.nvim',
        config = {},
    },
    {
        'ziontee113/color-picker.nvim',
        config = {},
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end,
    },
    {
        'windwp/nvim-autopairs',
        config = {},
    },
    {
        'zbirenbaum/neodim',
        event = 'LspAttach',
        config = function()
            require('neodim').setup({
                alpha = 0.75,
                blend_color = '#000000',
                update_in_insert = { enable = true, delay = 100 },
                hide = { virtual_text = true, signs = true, underline = true },
            })
        end,
    },
    -- Treesitter
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/playground',
    'p00f/nvim-ts-rainbow',
    { 'theHamsta/nvim-treesitter-commonlisp', dependencies = 'nvim-treesitter' },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzy-native.nvim', build = 'make' },
            { 'nvim-telescope/telescope-ui-select.nvim' },
        },
        cmd = { 'Telescope' },
        config = function()
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
        end,
    },
    { 'nvim-telescope/telescope-file-browser.nvim' },
    { 'nvim-telescope/telescope-fzy-native.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    
}
