local M = {}

local loaded = false
local default = nil
local BORDERS = { border = 'rounded' }

local function setup_lsp()
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
        on_attach = require('lsp.handlers').on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        flags = { debounce_text = 150 },
    }
end

local function get_server_config(server_name)
    local ok, server_config = pcall(require, 'lsp.config.' .. server_name)

    if not ok then
        return vim.tbl_deep_extend('force', {}, default)
    end

    return vim.tbl_deep_extend('force', {}, default, server_config)
end

local function setup_mason()
    require('mason').setup({ ui = BORDERS })
    require('mason-lspconfig').setup({
        ensure_installed = {
            'bashls',
            'intelephense',
            'rust_analyzer',
            'sumneko_lua',
        },
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
end

local function setup_null_ls()
    local builtins = require('null-ls').builtins
    local formatting = builtins.formatting
    local diagnostics = builtins.diagnostics
    local completion = builtins.completion

    require('null-ls').setup({
        sources = {
            formatting.stylua.with({
                extra_args = {
                    '--config-path',
                    os.getenv('XDG_CONFIG_HOME') .. '/stylua.toml',
                },
            }),
            diagnostics.eslint,
            diagnostics.zsh,
            completion.spell,
            diagnostics.twigcs,
            formatting.beautysh,
            formatting.phpcsfixer.with({
                args = {
                    '--no-interaction',
                    '--quiet',
                    '--config=' .. os.getenv('HOME') .. '/.config/.php-cs-fixer.php',
                    'fix',
                    '$FILENAME',
                },
            }),
        },
    })
end

function M.setup()
    if loaded == true then
        return
    end
    loaded = true

    setup_lsp()
    setup_mason()
    setup_null_ls()

    require('lspconfig.ui.windows').default_options.border = 'rounded'
    require('lsp_signature').setup()
end

return M
