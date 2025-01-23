---@type LazyPluginSpec[]
local M = {
    {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        build = function(plugin)
            local obj = vim.system({ 'cargo', 'build', '--release' }, { cwd = plugin.dir }):wait()
        end,
        ---@type lazydev.Config
        opts = {
            library = {
                'annotations',
                'lazydev.nvim',
                'lazy.nvim',
                'nvim-treesitter',
                'nvim-lspconfig',
                'snacks.nvim',
                { path = 'wezterm-types', mods = { 'wezterm' } },
                { path = 'luvit-meta/library', words = { 'vim%.uv', 'vim%.loop' } },
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                { path = 'LazyVim', words = { 'LazyVim' } },
            },
            integrations = {
                cmp = true,
                lsp = true,
            },
        },
    },
    { -- optional cmp completion source for require statements and module annotations
        'hrsh7th/nvim-cmp',
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = 'lazydev',
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            })
        end,
    },
    {
        'saghen/blink.compat',
        version = '*',
        lazy = true,
        opts = { impersonate_nvim_cmp = true },
    },
    { -- optional blink completion source for require statements and module annotations
        'saghen/blink.cmp',
        event = 'InsertEnter',
        dependencies = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-document-symbol',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lua',
            'JMarkin/cmp-diag-codes',
            'ray-x/cmp-treesitter',
            'saadparwaiz1/cmp_luasnip',
            'ncm2/ncm2',
            'onsails/Lspkind-nvim',
            {
                'L3MON4D3/LuaSnip',
                config = function(_, _)
                    require('luasnip/loaders/from_vscode').lazy_load()
                end,
                build = 'make install_jsregexp',
            },
        },
        opts = {
            appearance = {
                use_nvim_cmp_as_default = true,
            },
            keymap = {
                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide' },
                ['<CR>'] = { 'accept', 'fallback' },
                ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
                ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            },
            completion = {
                list = { selection = { preselect = false, auto_insert = false } },
                documentation = { auto_show = true, auto_show_delay_ms = 50 },
                ghost_text = { enabled = true },
            },
            sources = {
                -- add lazydev to your completion providers
                default = {
                    'lazydev',
                    'lsp',
                    'path',
                    'snippets',
                    'buffer',
                },
                providers = {
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                    crates = {
                        name = 'crates',
                        module = 'blink.compat.source',
                        fallbacks = { 'lsp' },
                    },
                },
            },
        },
    },
    {
        'Bilal2453/luvit-meta',
        lazy = true,
        cond = false,
    }, -- optional `vim.uv` typings
}

return M
