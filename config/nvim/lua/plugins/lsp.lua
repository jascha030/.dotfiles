return {
    {
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            {
                'j-hui/fidget.nvim',
                name = 'fidget',
                config = {
                    text = { spinner = 'dots' },
                    window = { relative = 'editor', blend = 0, zindex = nil },
                },
            },
        },
        ---@class PluginLspOpts
        opts = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = { spacing = 4, prefix = '●' },
                severity_sort = true,
            },
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
        },
        config = function(plugin, opts)
            require('core.utils').on_attach(function(client, buffer)
                require('lsp.keymaps').on_attach(client, buffer)
            end)

            -- diagnostics
            for name, icon in pairs(require('core.icons').diagnostics) do
                vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
            end

            vim.diagnostic.config(opts.diagnostics)

            local servers = opts.servers
            require('mason-lspconfig').setup({})
            require('mason-lspconfig').setup_handlers({
                function(server)
                    local conf = require('core.utils').get_server_config(server)

                    if server == 'rust_analyzer' then
                        require('rust-tools').setup({ server = conf })
                    else
                        require('lspconfig')[server].setup(conf)
                    end
                end,
            })
        end,
    },
    {
        'saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        dependencies = { { 'nvim-lua/plenary.nvim' } },
        config = true,
    },
    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
        opts = {
            ensure_installed = {
                'stylua',
                'shellcheck',
                'shfmt',
                'flake8',
            },
        },
        config = function(plugin, opts)
            require('mason').setup(opts)

            local mr = require('mason-registry')

            for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
    },
    -- {
    --     'lewis6991/hover.nvim',
    --     config = function()
    --         require('hover').setup({
    --             init = function()
    --                 require('hover.providers.lsp')
    --                 require('hover.providers.man')
    --             end,
    --             preview_opts = { border = nil },
    --             preview_window = false,
    --             title = true,
    --         })
    --
    --         -- Setup keymaps
    --         vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
    --         vim.keymap.set('n', 'gK', require('hover').hover_select, { desc = 'hover.nvim (select)' })
    --     end,
    -- },
    'simrat39/rust-tools.nvim',
    'b0o/schemastore.nvim',
    'folke/trouble.nvim',
    'ray-x/lsp_signature.nvim',
    'onsails/lspkind-nvim',
    { 'folke/lua-dev.nvim', lazy = true },
}
