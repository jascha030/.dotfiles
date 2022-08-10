if not require('utils').validate({ 'lspconfig', 'mason', 'mason-lspconfig', 'cmp_nvim_lsp', 'null-ls' }, 'lsp') then
    return
end

local lspconfig = require('lspconfig')
local cmp_lsp = require('cmp_nvim_lsp')

local default = require('lsp.config')

local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

local function get_default_server_config()
    return vim.tbl_deep_extend('force', default.server, { capabilities = capabilities })
end

local function load_server_config(server_name)
    local ok, config = pcall(require, 'lsp.config.' .. server_name)

    if not ok or type(config) ~= 'table' then
        return get_default_server_config()
    end

    return config
end

local loaded = false

-- Module
local M = {}

function M.get_server_config(server_name, opts)
    opts = opts or get_default_server_config()

    return vim.tbl_deep_extend('force', opts, load_server_config(server_name))
end

function M.lsp_handler(servername)
    lspconfig[servername].setup(M.get_server_config(servername))
end

function M.setup_lsp(config)
    for _, sign in ipairs(config.diagnostic.signs.active) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
    end

    vim.diagnostic.config(config.diagnostic)

    vim.lsp.handlers['textDocument/hover'] = config.handlers.hover
    vim.lsp.handlers['textDocument/signatureHelp'] = config.handlers.signature_help
end

function M.setup_extensions(opts)
    local mason = require('mason')
    local mason_lsp = require('mason-lspconfig')
    local null_ls = require('null-ls')

    mason.setup(opts['mason'])
    mason_lsp.setup(opts['mason-lspconfig'])
    mason_lsp.setup_handlers({ M.lsp_handler })

    null_ls.setup(opts['null-ls'])
end

function M.setup(opts)
    if loaded == true then
        return
    end

    loaded = true

    opts = opts or default
    opts = vim.tbl_deep_extend('force', default, opts)

    M.setup_lsp(opts.lsp)
    M.setup_extensions(opts.extensions)
end

return M
