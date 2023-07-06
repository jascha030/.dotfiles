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
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            'MunifTanjim/nui.nvim',
        },
        opts = {
            lsp = {
                hover = {
                    enabled = false,
                },
                progress = {
                    enabled = false,
                },
                notify = {
                    enabled = false,
                },
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true,
                },
                message = {
                    enabled = false,
                },
            },
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                -- command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                lsp_doc_border = true, -- add a border to hover docs and signature help
            },
        },
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
                source_selector = {
                    winbar = true,
                    statusline = false,
                },
                close_if_last_window = true,
                enable_git_status = true,
                enable_diagnostics = true,
                open_files_do_not_replace_types = { 'terminal', 'trouble' },
                window = {
                    position = 'right',
                    mappings = {
                        ['<c-v>'] = 'open_vsplit',
                    },
                },
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = false,
                        always_hide = {
                            '.DS_Store',
                        },
                    },
                },
            })
        end,
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
}
