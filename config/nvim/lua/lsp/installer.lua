-- Check if nvim-lsp-installer can be loaded or return
local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
    return
end

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require('lsp.handlers').on_attach,
        capabilities = require('lsp.handlers').capabilities,
    }

    if server.name == 'intelephense' then
        opts = vim.tbl_deep_extend('force', require('lsp.settings.intelephense'), opts)
    end

    if server.name == 'sumneko_lua' then
        opts = vim.tbl_deep_extend('force', require('lsp.settings.sumneko_lua'), opts)
    end

    if server.name == 'rust_analyzer' then
        opts = vim.tbl_deep_extend('force', require('lsp.settings.rust_analyzer'), opts)
    end

    server:setup(opts)
end)
