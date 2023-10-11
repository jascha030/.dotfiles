local M = {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
        'williamboman/mason.nvim',
        { 'williamboman/mason-lspconfig.nvim', lazy = true },
        { 'simrat39/rust-tools.nvim', ft = 'rs' },
        { 'chr4/nginx.vim', ft = 'nginx' },
        { 'LhKipp/nvim-nu', build = 'TSInstall nu', ft = 'nu' },
        { 'folke/lua-dev.nvim', event = 'VeryLazy' },
        { 'folke/neodev.nvim', lazy = true },
        { 'ray-x/lsp_signature.nvim', config = true },
        {
            'lvimuser/lsp-inlayhints.nvim',
            lazy = true,
            config = function(opts)
                require('nu').setup(opts)
            end,
        },
        { 'b0o/schemastore.nvim', ft = { 'json', 'yaml', 'yml' } },
        {
            'gbprod/phpactor.nvim',
            ft = { 'php', 'yaml' },
            cmd = { 'PhpActor' },
            keys = { { '<leader>pc', ':PhpActor context_menu<cr>', desc = 'PhpActor context menu' } },
            build = function()
                require('phpactor.handler.update')()
            end,
            opts = {
                install = { check_on_startup = 'daily', bin = vim.fn.stdpath('data') .. '/mason/bin/phpactor' },
                lspconfig = { enabled = true },
            },
        },
        {
            'j-hui/fidget.nvim',
            name = 'fidget',
            tag = 'legacy',
            lazy = true,
            opts = {
                text = { spinner = 'dots' },
                window = { relative = 'editor', blend = 0, zindex = nil },
                sources = { phpactor = { ignore = true } },
            },
        },
        {
            'nvimdev/lspsaga.nvim',
            lazy = true,
            opts = { border_style = BORDER },
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
    local get_server_config = require('jascha030.lsp').get_server_config

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
                -- E.g. jascha030.lsp.config.lua_ls.get_server_config() runs neodev setup before config table is returned.
                local config = get_server_config(server)

                lspconfig[server].setup(config)
            end,
            rust_analyzer = function()
                require('rust-tools').setup({
                    server = get_server_config('rust_analyzer'),
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
