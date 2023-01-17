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
    'goolord/alpha-nvim',
    'kyazdani42/nvim-tree.lua',
    'sheerun/vim-polyglot',
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
            background_color = get_background(),
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
        config = {
            cursorline = { enable = true, timeout = 1000, number = false },
            cursorword = { enable = true, min_length = 3, hl = { underline = true } },
        },
    },
    {
        'yamatsum/nvim-nonicons',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
    },
    {
        'noib3/nvim-cokeline',
        config = {
            show_if_buffers_are_at_least = 2,
            buffers = {
                focus_on_delete = false,
                new_buffers_position = 'next',
            },
        },
    },
    { 'norcalli/nvim-colorizer.lua', name = 'colorizer', config = true },
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
