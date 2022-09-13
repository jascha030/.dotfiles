local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lsp = require('mason-lspconfig')
local rt = require('rust-tools')

local function get_default_server_config()
    return require('lsp.config').get_defaults().server
end

local function get_server_config(server_name, opts)
    opts = opts or {}

    local ok, server_config = pcall(require, 'lsp.config.' .. server_name)
    if not ok or type(server_config) ~= 'table' then
        server_config = get_default_server_config()
    end

    -- local mason_ok, mason_config = pcall(require, 'mason-lspconfig.server_configurations.' .. server_name)
    -- if mason_ok then
        -- server_config = vim.tbl_deep_extend('force', mason_config, server_config)
    -- end

    return vim.tbl_deep_extend('force', opts, server_config)
end

local M = {}

function M.setup(conf)
    mason.setup(conf['mason'] or {})
    mason_lsp.setup(conf['mason-lspconfig'] or {})

    mason_lsp.setup_handlers({
        function(server)
            if server == 'angularls' then
                vim.pretty_print(get_server_config(server))
            end
            lspconfig[server].setup(get_server_config(server))
        end,
        -- Overrides
        ['rust_analyzer'] = function(server)
            rt.setup({ server = get_server_config(server) })
        end,
    })
end

return M
