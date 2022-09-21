local M = {}

local loaded = false

local function setup_lsp(conf)
    for _, sign in ipairs(conf.diagnostic.signs.active) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
    end

    vim.diagnostic.config(conf.diagnostic)
    vim.lsp.handlers['textDocument/hover'] = conf.handlers.hover
    vim.lsp.handlers['textDocument/signatureHelp'] = conf.handlers.signature_help
end

local function get_server_config(server_name, opts)
    local ok, server_config = pcall(require, 'lsp.config.' .. server_name)

    if not ok or type(server_config) ~= 'table' then
        server_config = require('lsp.config').options.server
    end

    return vim.tbl_deep_extend('force', {}, opts or {}, server_config)
end

local function setup_mason(opts)
    require('mason').setup(opts['mason'] or {})
    require('mason-lspconfig').setup(opts['mason-lspconfig'] or {})
    require('mason-lspconfig').setup_handlers({
        function(server)
            if server == 'rust_analyzer' then
                require('rust-tools').setup({ server = get_server_config(server) })
            end

            require('lspconfig')[server].setup(get_server_config(server))
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
            formatting.stylua.with({ extra_args = { '--config-path', os.getenv('XDG_CONFIG_HOME') .. '/stylua.toml' } }),
            diagnostics.eslint,
            completion.spell,
        },
    })
end

function M.setup(opts)
    if loaded == true then
        return
    end

    loaded = true

    local config = require('lsp.config')

    config.extend(opts)

    setup_lsp(config.options.lsp)
    setup_mason(config.options.extensions)
    setup_null_ls()
end

return M
