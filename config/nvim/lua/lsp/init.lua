local M = {}

local loaded = false
local default = nil

local function setup_lsp(conf)
    for _, sign in ipairs(conf.diagnostic.signs.active) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
    end

    vim.diagnostic.config(conf.diagnostic)
    vim.lsp.handlers['textDocument/hover'] = conf.handlers.hover
    vim.lsp.handlers['textDocument/signatureHelp'] = conf.handlers.signature_help
    default = require('lsp.config').options.server
end

local function get_server_config(server_name, opts)
    local ok, server_config = pcall(require, 'lsp.config.' .. server_name)

    if not ok then
        return vim.tbl_deep_extend('force', {}, default)
    end

    if opts and type(server_config) == 'function' then
        local conf_ok
        conf_ok, server_config = pcall(server_config, opts)

        if not conf_ok then
            return vim.tbl_deep_extend('force', {}, default)
        end
    end

    return vim.tbl_deep_extend('force', {}, default, server_config)
end

local function setup_mason(opts)
    require('mason').setup(opts['mason'] or {})
    require('mason-lspconfig').setup(opts['mason-lspconfig'] or {})
    require('mason-lspconfig').setup_handlers({
        function(server)
            local conf = get_server_config(server, opts.server_opts[server] or nil)

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

    require('lsp_signature').setup()
end

return M
