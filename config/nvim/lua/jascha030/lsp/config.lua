---@class jascha030.lsp.Config
local M = {}

---@param server string LSP server name
---@param message string
---@param level? integer
local function config_error(server, message, level)
    error('Failed to load config for ' .. server .. ' ' .. message, level)
end

-- Server client capabilities
---@return table
function M.client_capabilities()
    local caps = { vim.lsp.protocol.make_client_capabilities() }

    local ok, cmp = pcall(require, 'cmp_nvim_lsp')
    if ok then
        table.insert(caps, cmp.default_capabilities())
    end

    table.insert(caps, {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = false,
            },
        },
    })

    return vim.tbl_deep_extend('force', unpack(caps))
end

local defaults = {
    capabilities = M.client_capabilities(),
    flags = { debounce_text = 150 },
}

---@param server string LSP server name
---@return table
function M.get_server_config(server)
    local ok, config = pcall(require, 'jascha030.lsp.servers.' .. server)
    if not ok then
        config = {}
    end

    if type(config) == 'function' then
        ok, config = pcall(config)
        if not ok then
            config_error(server, 'Error: ' .. config, 2)
        end

        if type(config) ~= 'table' then
            config_error(server, 'provided callback should be a table, got ' .. type(config) .. ' instead', 2)
        end

        return M.extend(config)
    end

    if type(config) ~= 'table' then
        config_error(server, 'a table was expected, got ' .. type(config) .. ' instead', 2)
    end

    return M.extend(config)
end

function M.extend(config)
    local merge = {
        {},
        vim.deepcopy(defaults),
    }

    if type(config) == 'table' and not vim.tbl_isempty(config) then
        table.insert(merge, config)
    end

    return vim.tbl_deep_extend('force', table.unpack(merge))
end

return M
