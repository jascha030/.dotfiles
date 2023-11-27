local M = {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre' },
    dependencies = {
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'ray-x/lsp_signature.nvim' },
        { import = 'jascha030.plugins.spec.neodev', ft = 'lua' },
        {
            'nvimdev/lspsaga.nvim',
            lazy = true,
            opts = {
                ui = { border = BORDER },
                lightbulb = { enable = false },
            },
            dependencies = { 'nvim-treesitter/nvim-treesitter' },
        },
    },
    opts = {
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
        format = {
            formatting_options = nil,
            timeout_ms = 10000,
        },
        inlay_hints = {
            enabled = false,
        },
    },
}

function M.config(_, opts)
    local lspconfig = require('lspconfig')
    local get_server_config = require('jascha030.lsp.config').get_server_config

    require('lspconfig.ui.windows').default_options.border = BORDER
    require('jascha030.lsp').setup(opts)
    require('mason-lspconfig').setup({
        automatic_installation = true,
        ensure_installed = {
            'angularls',
            'bashls',
            'intelephense',
            'jsonls',
            'lua_ls',
            'marksman',
            'phpactor',
            'rust_analyzer',
            'tailwindcss',
        },
        handlers = {
            function(server)
                -- Specifically resolve before setup(), allows for before_init logic in case of config function.
                local config = get_server_config(server)

                lspconfig[server].setup(config)
            end,
            ['rust_analyzer'] = function()
                local server = get_server_config('rust_analyzer')

                require('rust-tools').setup({
                    server = server,
                    tools = {
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
end

return M
