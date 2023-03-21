return {
    {
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'simrat39/rust-tools.nvim',
            {
                'gbprod/phpactor.nvim',
                dependencies = { 'nvim-lua/plenary.nvim' },
            },
            {
                'j-hui/fidget.nvim',
                name = 'fidget',
                config = {
                    text = { spinner = 'dots' },
                    window = { relative = 'editor', blend = 0, zindex = nil },
                },
            },
            { 'LhKipp/nvim-nu', build = 'TSInstall nu' },
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
            require('nu').setup({})

            require('core.utils').on_attach(function(client, buffer)
                require('lsp.keymaps').on_attach(client, buffer)
            end)

            -- diagnostics
            for name, icon in pairs(require('core.icons').icons.diagnostics) do
                vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
            end

            vim.diagnostic.config(opts.diagnostics)

            local servers = opts.servers
            require('mason-lspconfig').setup({})
            require('mason-lspconfig').setup_handlers({
                function(server)
                    local conf = require('core.utils').get_server_config(server)

                    if server == 'phpactor' then
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
                    end
                    if server == 'rust_analyzer' then
                        local rt = require('rust-tools')

                        rt.setup({
                            tools = {
                                reload_workspace_from_cargo_toml = true,
                                inlay_hints = {
                                    auto = true,
                                    only_current_line = true,
                                    show_parameter_hints = true,
                                },
                            },
                            server = {
                                on_attach = function(_, bufnr)
                                    vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })

                                    vim.keymap.set(
                                        'n',
                                        '<Leader>a',
                                        rt.code_action_group.code_action_group,
                                        { buffer = bufnr }
                                    )
                                end,
                            },
                        })
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
                'phpactor',
            },
            ui = BORDERS,
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
    'b0o/schemastore.nvim',
    'folke/trouble.nvim',
    'ray-x/lsp_signature.nvim',
    'onsails/lspkind-nvim',
    { 'folke/lua-dev.nvim', lazy = true },
}
