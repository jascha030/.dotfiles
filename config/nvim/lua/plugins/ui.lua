local function get_background()
    if require('utils.theme').is_dark() then
        return '#1e2030'
    else
        return '#e7e9ef'
    end
end

return {
    {
        dir = '~/.development/Projects/Lua/nitepal.nvim',
        dependencies = { 'hoob3rt/lualine.nvim' },
    },
    {
        'goolord/alpha-nvim',
        event = 'VimEnter',
        config = function(_, _)
            local opts = require('alpha.themes.startify').config

            require('alpha').setup(opts)
        end,
    },
    'sheerun/vim-polyglot',
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
        },
        config = function(_, _)
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

            require('neo-tree').setup({
                close_if_last_window = true,
                enable_git_status = true,
                enable_diagnostics = true,
                open_files_do_not_replace_types = { 'terminal', 'trouble' },
                window = {
                    position = 'right',
                },
                filesystem = {
                    hide_dotfiles = false
                }
            })
        end,
    },
    {
        'rcarriga/nvim-notify',
        keys = {
            {
                '<leader>un',
                function()
                    require('notify').dismiss({ silent = true, pending = true })
                end,
                desc = 'Delete all Notifications',
            },
        },
        opts = {
            background_colour = get_background(),
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
    },
    {
        'yamatsum/nvim-cursorline',
        opts = {
            cursorline = { enable = true, timeout = 1000, number = false },
            cursorword = { enable = true, min_length = 3, hl = { underline = true } },
        },
    },
    {
        'yamatsum/nvim-nonicons',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
    },
    'noib3/nvim-cokeline',
    {
        'norcalli/nvim-colorizer.lua',
        name = 'colorizer',
        config = true,
    },
    {
        'brenoprata10/nvim-highlight-colors',
        name = 'nvim-highlight-colors',
        opts = {
            render = 'first_column',
        },
    },
    {
        'stevearc/dressing.nvim',
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require('lazy').load({ plugins = { 'dressing.nvim' } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require('lazy').load({ plugins = { 'dressing.nvim' } })
                return vim.ui.input(...)
            end
        end,
    },
}
