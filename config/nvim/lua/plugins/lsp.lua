SERVERS = {
    'angularls',
    'bashls',
    'intelephense',
    'jsonls',
    'lua_ls',
    'marksman',
    'phpactor',
    'rust_analyzer',
    -- 'sourcekit',
    'tailwindcss',
}

---@type LazyPluginSpec[]|string[]
return {
    'williamboman/mason-lspconfig.nvim',
    'ray-x/lsp_signature.nvim',
    'folke/lazydev.nvim',
    'yioneko/nvim-vtsls',
    {
        'nvimdev/lspsaga.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {
            ui = { border = BORDER },
            lightbulb = { enable = false },
        },
    },
    {
        'simrat39/rust-tools.nvim',
        ft = 'rs',
        dependencies = { 'rust-lang/rust.vim' },
        lazy = true,
    },
    {
        'j-hui/fidget.nvim',
        name = 'fidget',
        tag = 'legacy',
        opts = {
            text = { spinner = 'dots' },
            window = { relative = 'editor', blend = 0, zindex = nil },
            sources = { phpactor = { ignore = true } },
        },
    },
    {
        'williamboman/mason.nvim',
        cmd = { 'Mason' },
        keys = {
            { '<leader><leader>m', '<cmd>Mason<cr>', desc = 'Mason' },
        },
        opts = function(_, opts)
            opts.ensure_installed = {
                'angular-language-server',
                'bash-language-server',
                'beautysh',
                'black',
                'blade-formatter',
                'css-lsp',
                'eslint_d',
                'flake8',
                'html-lsp',
                'intelephense',
                'isort',
                'json-lsp',
                'lua-language-server',
                'luacheck',
                'markdownlint',
                'marksman',
                'phpactor',
                'phpstan',
                'psalm',
                'rust-analyzer',
                'shellcheck',
                'shfmt',
                'stylelint',
                'stylelint-lsp',
                'stylua',
                'svelte-language-server',
                'tailwindcss-language-server',
                'taplo',
                'typescript-language-server',
                'yaml-language-server',
                'yamlfix',
                'yamlfmt',
            }

            opts.ui = BORDERS

            return opts
        end,
        lazy = true,
        config = function(_, opts)
            require('mason').setup(opts)

            local registry = require('mason-registry')

            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = registry.get_package(tool)

                    if not p:is_installed() then
                        p:install()
                    end
                end
            end

            if registry.refresh then
                registry.refresh(ensure_installed)
            else
                ensure_installed()
            end

            for _, tool in ipairs(opts.ensure_installed) do
                local p = registry.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
    },
    {
        'gbprod/phpactor.nvim',
        ft = { 'php' },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'neovim/nvim-lspconfig',
        },
        build = function()
            require('phpactor.handler.update')()
        end,
        config = function(_, opts)
            require('phpactor').setup(opts)
        end,
    },
    {
        'neovim/nvim-lspconfig',
        priority = 70,
        lazy = false,
        version = '*',
        opts = function(_, _)
            ---@class PluginLspOpt
            local lsp_config = {
                ---@type lspconfig.Config
                ensure_installed = SERVERS,
                servers = {
                    sourcekit = function()
                        local lspconfig = require('lspconfig')
                        lspconfig.sourcekit.setup({
                            cmd = {
                                'xcrun',
                                'sourcekit-lsp',
                            },
                            filetypes = {
                                'swift',
                                'c',
                                'cpp',
                                'objective-c',
                                'objective-cpp',
                            },
                            root_dir = require('lspconfig.util').root_pattern('Package.swift', '.git'),
                            capabilities = {
                                workspace = {
                                    didChangeWatchedFiles = {
                                        dynamicRegistration = true,
                                    },
                                },
                            },
                        })
                    end,
                },
                ---@type vim.diagnostic.Opts
                diagnostics = {
                    signs = { text = require('jascha030.core.icons').get_icons().diagnostics },
                    underline = true,
                    update_in_insert = false,
                    severity_sort = true,
                    virtual_text = {
                        spacing = 4,
                        source = 'if_many',
                        prefix = '●',
                    },
                },
                inlay_hints = { enabled = vim.fn.has('nvim-0.10') == 1 },
            }

            return lsp_config
        end,
        config = function(_, opts)
            require('jascha030.lsp').setup(opts)
        end,
    },
    -- {
    --     'neovim/nvim-lspconfig',
    --     -- priority = 70,
    --     -- lazy = false,
    --     event = 'VeryLazy',
    --     opts = {
    --         ---@type vim.diagnostic.Opts
    --         diagnostics = {
    --             signs = { text = require('jascha030.core.icons').get_icons().diagnostics },
    --             underline = true,
    --             update_in_insert = false,
    --             severity_sort = true,
    --             virtual_text = {
    --                 spacing = 4,
    --                 source = 'if_many',
    --                 prefix = '●',
    --             },
    --         },
    --         inlay_hints = { enabled = vim.fn.has('nvim-0.10') == 1 },
    --     },
    --     config = function(_, opts)
    --         -- require('lspconfig').setup()
    --         require('jascha030.lsp').setup(opts)
    --     end,
    -- },
}
