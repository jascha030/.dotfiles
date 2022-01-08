-- Check if nvim-lsp-installer can be loaded or return
local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require('lsp.handlers').on_attach,
        capabilities = require('lsp.handlers').capabilities,
    }

    local custom_server_options = { 'intelephense', }

    for server_name in pairs(custom_server_options) do
        if server.name == name then
            local server_opts = require('lsp.settings.' .. server_name)
            opts = vim.tbl_deep_extend("force", server_opts, opts)
        end
    end

    server:setup(opts)
end)
