return {
    'wakatime/vim-wakatime',
    'f-person/git-blame.nvim',
    { 'ojroques/vim-oscyank' },
    { 'nvim-lua/plenary.nvim', lazy = true },
    { 'ziontee113/color-picker.nvim', lazy = true },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
    },
    { 'petertriho/nvim-scrollbar', config = true },
    { 'luukvbaal/stabilize.nvim', config = true },
    {
        'zbirenbaum/copilot.lua',
        cmd = 'InsertEnter',
        dependencies = 'nvim-lspconfig',
        opts = {
            panel = { enabled = false },
            -- suggestion = {
            --     auto_trigger = true,
            --     -- Use alt to interact with Copilot.
            --     keymap = {
            --         -- Disable the built-in mapping, we'll configure it in nvim-cmp.
            --         accept = false,
            --         accept_word = '<M-w>',
            --         accept_line = '<M-l>',
            --         next = '<M-]>',
            --         prev = '<M-[>',
            --         dismiss = '/',
            --     },
            -- },
            filetypes = { markdown = true },
        },
        event = 'VimEnter',
        config = function(_, opts)
            local cmp = require('cmp')
            local copilot = require('copilot.suggestion')
            local luasnip = require('luasnip')

            require('copilot').setup(opts)

            ---@param trigger boolean
            local function set_trigger(trigger)
                if not trigger and copilot.is_visible() then
                    copilot.dismiss()
                end

                vim.b['copilot_suggestion_auto_trigger'] = trigger
                vim.b['copilot_suggestion_hidden'] = not trigger
            end

            -- Hide suggestions when the completion menu is open.
            cmp.event:on('menu_opened', function()
                set_trigger(false)
            end)

            cmp.event:on('menu_closed', function()
                set_trigger(not luasnip.expand_or_locally_jumpable())
            end)
        end,
    },
    {
        'saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = true,
        lazy = true,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        name = 'indent_blankline',
        main = 'ibl',
        opts = {
            indent = {
                char = '│',
            },
            exclude = {
                filetypes = {
                    'dashboard',
                },
            },
            scope = {
                enabled = true,
            },
        },
    },
    {
        'terrortylor/nvim-comment',
        name = 'nvim_comment',
        config = true,
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        config = function(_, _)
            local keymaps = require('jascha030.config').options.keymaps
            local wk = require('which-key')

            for mtype, tmaps in pairs(keymaps) do
                local results = {}

                for kmap, args in pairs(tmaps) do
                    results[kmap] = { args[1], args[1] }
                end

                wk.register(results, { nowait = true, mode = mtype })
            end
        end,
    },
    {
        'ziontee113/icon-picker.nvim',
        cond = false,
    },
}
