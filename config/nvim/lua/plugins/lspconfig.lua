local SERVERS = {
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

---@diagnostic disable: missing-fields
---@type LazyPluginSpec
local M = {
    'neovim/nvim-lspconfig',
    priority = 70,
    lazy = false,
    version = '*',
    dependencies = {
        'williamboman/mason.nvim',
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
    },
    opts = function(_, opts)
        ---@class PluginLspOpt
        local lsp_config = {
            -- ---@type lspconfig.options
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
            diagnostics = {
                signs = true,
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
}

function M.config(_, opts)
    local lspconfig = require('lspconfig')
    local get_server_config = require('jascha030.lsp.config').get_server_config

    -- For some reason this one is not available through Mason, so we have to do it manually.
    opts.servers.sourcekit()
    require('lspconfig.configs').vtsls = require('vtsls').lspconfig

    require('lspconfig.ui.windows').default_options.border = BORDER
    require('mason-lspconfig').setup({
        automatic_installation = true,
        ensure_installed = SERVERS,
        handlers = {
            function(server)
                -- Resolve before calling setup, enables pre-setup logic to run if server_config returns function.
                local config = get_server_config(server)

                lspconfig[server].setup(config)
            end,
            ['rust_analyzer'] = function()
                local server = get_server_config('rust_analyzer')

                require('rust-tools').setup({
                    server = server,
                    tools = {
                        runnables = {
                            use_telescope = true,
                        },
                        reload_workspace_from_cargo_toml = true,
                        inlay_hints = {
                            auto = true,
                            only_current_line = false,
                            show_parameter_hints = true,
                        },
                    },
                })
            end,
        },
    })

    require('jascha030.lsp').setup(opts)
end

return M
