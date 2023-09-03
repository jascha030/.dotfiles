local servers = {
    'angularls',
    'bashls',
    'intelephense',
    'jsonls',
    'lua_ls',
    'phpactor',
    'rust_analyzer',
    'tailwindcss',
}

return {
    {
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        lazy = false,
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            { 'simrat39/rust-tools.nvim', ft = 'rs' },
            {
                'gbprod/phpactor.nvim',
                ft = { 'php' },
                cmd = { 'PhpActor' },
                keys = {
                    {
                        '<leader>pc',
                        ':PhpActor context_menu<cr>',
                        desc = 'PhpActor context menu',
                    },
                },
                build = function()
                    require('phpactor.handler.update')()
                end,
            },
            {
                'j-hui/fidget.nvim',
                name = 'fidget',
                opts = {
                    text = { spinner = 'dots' },
                    window = { relative = 'editor', blend = 0, zindex = nil },
                },
                event = 'VeryLazy',
            },
            { 'LhKipp/nvim-nu', build = 'TSInstall nu' },
            { 'folke/lua-dev.nvim', event = 'VeryLazy' },
            { 'folke/neodev.nvim', opts = {}, lazy = true },
            { 'ray-x/lsp_signature.nvim' },
            { 'lvimuser/lsp-inlayhints.nvim', config = true },
            'saecki/crates.nvim',
        },
        opts = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = true,
                severity_sort = true,
            },
            format = {
                formatting_options = nil,
                timeout_ms = 10000,
            },
        },
        config = function(_, opts)
            local lsp = require('lsp')
            local lspconfig = require('lspconfig')

            lsp.setup(opts)

            require('nu').setup({})

            require('mason-lspconfig').setup({
                ensure_installed = servers,
                automatic_installation = true,
            })

            require('mason-lspconfig').setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup(lsp.get_server_config(server_name))
                end,
                ['lua_ls'] = function()
                    require('neodev').setup({})

                    lspconfig.lua_ls.setup(lsp.get_server_config('lua_ls'))
                end,
                ['rust_analyzer'] = function()
                    require('rust-tools').setup({
                        tools = {
                            reload_workspace_from_cargo_toml = true,
                            inlay_hints = {
                                auto = false,
                                only_current_line = false,
                                show_parameter_hints = true,
                            },
                        },
                        server = lsp.get_server_config('rust_analyzer'),
                    })
                end,
                phpactor = function()
                    require('phpactor').setup({
                        install = {
                            bin = '/usr/local/bin/phpactor',
                        },
                        lspconfig = {
                            enabled = false,
                            -- options = require('lsp.config.phpactor'),
                        },
                    })

                    lspconfig.phpactor.setup(lsp.get_server_config('phpactor'))
                end,
            })
        end,
    },
    {
        'nvimdev/lspsaga.nvim',
        event = 'LspAttach',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
    },
    {
        'folke/trouble.nvim',
        opts = { position = 'bottom' },
        event = 'VeryLazy',
        lazy = true,
    },
    { 'b0o/schemastore.nvim', ft = { 'json' } },
    'onsails/lspkind-nvim',
    {
        'chr4/nginx.vim',
        ft = { 'nginx' },
    },
    {
        'saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        dependencies = { { 'nvim-lua/plenary.nvim' } },
        config = true,
        lazy = true,
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
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end

            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end

            for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
        lazy = false,
    },
}
