-- TODO: apparently nvim-lsp-installer.on_server_ready is deprecated, use builtin nvim-lsp method instead

local function get_server_config(opts, server)
    local mname = 'lsp.config.' .. server.name

    local ok, config = pcall(function(m)
        return require(m)
    end, mname)

    return not ok and opts or vim.tbl_deep_extend('force', config, opts)
end

return {
    setup = function(opts)
        opts = opts or {}
        require('nvim-lsp-installer').on_server_ready(function(server)
            server:setup(get_server_config(opts, server))
        end)
    end,
}
