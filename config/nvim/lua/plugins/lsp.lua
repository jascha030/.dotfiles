local BORDERS = { border = 'rounded' }
local default = nil

local function get_server_config(server_name)
    local ok, server_config = pcall(require, 'lsp.config.' .. server_name)

    if not ok then
        return vim.tbl_deep_extend('force', {}, default)
    end

    return vim.tbl_deep_extend('force', {}, default, server_config)
end

return {
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({ ui = BORDERS })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            local signs = {
                { name = 'DiagnosticSignError', text = '' },
                { name = 'DiagnosticSignWarn', text = '' },
                { name = 'DiagnosticSignHint', text = '' },
                { name = 'DiagnosticSignInfo', text = '' },
            }

            for _, sign in ipairs(signs) do
                vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
            end

            vim.diagnostic.config({
                virtual_text = false,
                float = {
                    focusable = false,
                    style = 'minimal',
                    border = 'rounded',
                    source = 'always',
                    header = '',
                    prefix = '',
                },
                update_in_insert = true,
                underline = true,
                severity_sort = true,
            })

            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, BORDERS)
            vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, BORDERS)

            default = {
                on_attach = require('lsp.on_attach'),
                capabilities = require('cmp_nvim_lsp').default_capabilities(
                    vim.lsp.protocol.make_client_capabilities()
                ),
                flags = { debounce_text = 150 },
            }

            require('mason-lspconfig').setup({
                ensure_installed = { 'bashls', 'intelephense', 'rust_analyzer', 'sumneko_lua' },
            })

            require('mason-lspconfig').setup_handlers({
                function(server)
                    local conf = get_server_config(server)

                    if server == 'rust_analyzer' then
                        require('rust-tools').setup({ server = conf })
                    else
                        require('lspconfig')[server].setup(conf)
                    end
                end,
            })

            require('lspconfig.ui.windows').default_options.border = 'rounded'
            require('lsp_signature').setup()
        end,
    },

    {
        'saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        dependencies = { { 'nvim-lua/plenary.nvim' } },
        config = true,
    },
    {
        'j-hui/fidget.nvim',
        config = function()
            require('fidget').setup({
                text = { spinner = 'dots' },
                window = { relative = 'editor', blend = 0, zindex = nil },
            })
        end,
    },
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-vsnip',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'ncm2/ncm2',
    'simrat39/rust-tools.nvim',
    'b0o/schemastore.nvim',
    'folke/trouble.nvim',
    'ray-x/lsp_signature.nvim',
    'onsails/lspkind-nvim',
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-telescope/telescope-dap.nvim',
    { 'folke/lua-dev.nvim', lazy = true },
}
