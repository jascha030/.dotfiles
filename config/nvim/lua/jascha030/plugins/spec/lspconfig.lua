local M = {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre' },
    dependencies = {
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'ray-x/lsp_signature.nvim' },
        {
            'lvimuser/lsp-inlayhints.nvim',
            opts = {
                inlay_hints = {
                    parameter_hints = {
                        show = true,
                        prefix = '<-- ',
                        separator = ', ',
                        remove_colon_start = false,
                        remove_colon_end = true,
                    },
                    type_hints = {
                        show = false,
                        prefix = ': ',
                        separator = ', ',
                        remove_colon_start = false,
                        remove_colon_end = false,
                    },
                    only_current_line = true,
                    labels_separator = '  ',
                    max_len_align = true,
                    max_len_align_padding = 1,
                    highlight = 'LspInlayHint',
                    priority = 0,
                },
            },
        },
        { 'chr4/nginx.vim', ft = 'nginx' },
        { 'b0o/schemastore.nvim', ft = { 'json', 'yaml', 'yml' } },
        {
            'simrat39/rust-tools.nvim',
            ft = 'rs',
            dependencies = { 'rust-lang/rust.vim' },
            lazy = true,
        },
        {
            'folke/neodev.nvim',
            name = 'neodev',
            ft = 'lua',
            opts = {},
        },
        {
            'phpactor/phpactor',
            build = 'composer install --no-dev --optimize-autoloader',
            ft = 'php',
        },
        {
            'nvimdev/lspsaga.nvim',
            dependencies = { 'nvim-treesitter/nvim-treesitter' },
            lazy = true,
            opts = {
                ui = { border = BORDER },
                lightbulb = { enable = false },
            },
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
            enabled = true,
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
end

return M
