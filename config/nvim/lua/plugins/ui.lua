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
        config = function(config)
            local startify = require('alpha.themes.startify')
            require('alpha.term')

            local section = startify.section
            local term_height = 10
            local term_or_text = nil
            local term_padding = nil
            local ret = os.execute('command -v neo &>/dev/null')

            if ret == 0 then
                term_or_text = {
                    type = 'terminal',
                    command = "neo --fps=20 --speed=5 -D -m 'NEO VIM' -d 0.5 -l 1,1",
                    width = 36,
                    height = term_height,
                    opts = {
                        position = 'center',
                        redraw = true,
                        window_config = {},
                    },
                }
                term_padding = { type = 'padding', val = term_height + 5 }
            else
                term_or_text = {
                    type = 'text',
                    val = {
                        [[  ooooo      ooo oooooo     oooo ooooo ooo        ooooo  ]],
                        [[  `888b.     `8'  `888.     .8'  `888' `88.       .888'  ]],
                        [[   8 `88b.    8    `888.   .8'    888   888b     d'888   ]],
                        [[   8   `88b.  8     `888. .8'     888   8 Y88. .P  888   ]],
                        [[   8     `88b.8      `888.8'      888   8  `888'   888   ]],
                        [[   8       `888       `888'       888   8    Y     888   ]],
                        [[  o8o        `8        `8'       o888o o8o        o888o  ]],
                    },
                    opts = { position = 'center', hl = 'DashboardHeader' },
                }
                term_padding = { type = 'padding', val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) }) }
            end

            config.layout = {
                { type = 'padding', val = 2 },
                term_or_text,
                { type = 'padding', val = 2 },
                {
                    type = 'group',
                    val = {
                        section.top_buttons,
                        section.mru_cwd,
                        section.mru,
                    },
                    opts = { position = 'center' },
                },
                { type = 'padding', val = 1 },
                section.bottom_buttons,
                section.footer,
            }

            require('alpha').setup(config)
        end,
    },
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
