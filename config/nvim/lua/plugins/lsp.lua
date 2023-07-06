return {
    {
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'simrat39/rust-tools.nvim',
            { 'gbprod/phpactor.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
            {
                'j-hui/fidget.nvim',
                name = 'fidget',
                opts = {
                    text = { spinner = 'dots' },
                    window = { relative = 'editor', blend = 0, zindex = nil },
                },
            },
            { 'LhKipp/nvim-nu', build = 'TSInstall nu' },
            { 'folke/lua-dev.nvim', lazy = true },
            { 'folke/neodev.nvim', opts = {}, lazy = true },
            { 'ray-x/lsp_signature.nvim' },
            {
                'saecki/crates.nvim',
                event = { 'BufRead Cargo.toml' },
                dependencies = { { 'nvim-lua/plenary.nvim' } },
                config = true,
                lazy = true,
            },
        },
        ---@class PluginLspOpts
        opts = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = true,
                severity_sort = true,
            },
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
        },
        config = function(_, opts)
            require('lsp').setup()
            require('nu').setup({})
            require('core.utils').on_attach(function(client, buffer)
                local caps = client.server_capabilities
                -- Enable completion triggered by <C-X><C-O>
                -- See `:help omnifunc` and `:help ins-completion` for more information.
                if caps.completionProvider then
                    vim.bo[buffer].omnifunc = 'v:lua.vim.lsp.omnifunc'
                end

                require('lsp.keymaps').on_attach(client, buffer)

                if client.name == 'phpactor' then
                    client.server_capabilities.hoverProvider = false
                end
            end)

            -- diagnostics
            for name, icon in pairs(require('core.icons').icons.diagnostics) do
                vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
            end

            vim.diagnostic.config(opts.diagnostics)

            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
                silent = true,
                border = BORDER,
            })

            local get_server_config = require('core.utils').get_server_config
            local lspconfig = require('lspconfig')

            require('mason-lspconfig').setup({})
            require('mason-lspconfig').setup_handlers({
                function(server)
                    lspconfig[server].setup(get_server_config(server))
                end,
                ['lua_ls'] = function()
                    require('neodev').setup({})

                    lspconfig.lua_ls.setup(get_server_config('lua_ls'))
                end,
                ['rust_analyzer'] = function()
                    require('rust-tools').setup({
                        tools = {
                            reload_workspace_from_cargo_toml = true,
                            inlay_hints = {
                                auto = true,
                                only_current_line = false,
                                show_parameter_hints = true,
                            },
                        },
                        server = get_server_config('rust_analyzer'),
                    })
                end,
                phpactor = function()
                    require('phpactor').setup({
                        install = {
                            bin = '/usr/local/bin/phpactor',
                        },
                        lspconfig = {
                            enabled = true,
                            options = {
                                cmd = { 'phpactor', 'language-server' },
                            },
                        },
                    })
                end,
            })
        end,
    },
    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
        opts = {
            ensure_installed = {
                'lua-language-server',
                'rust-analyzer',
                'stylua',
                'shellcheck',
                'shfmt',
                'flake8',
                'phpactor',
            },
            ui = BORDERS,
        },
        config = function(_, opts)
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
    { 'folke/trouble.nvim', opts = { position = 'bottom' } },
    'b0o/schemastore.nvim',
    'onsails/lspkind-nvim',
}
