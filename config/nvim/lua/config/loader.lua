local M = {}

function M.unload(mod)
    if not package.loaded[mod] then
        return
    end

    package.loaded[mod] = nil
end

function M.resolve_config(mod)
    local ok, config = pcall(require, 'config.' .. mod)

    return ok and config or nil
end

local function attempt_plugin_setup(mod, config)
    local res = nil
    local ok, plugin = pcall(require, mod)

    if not ok then
        return false, res
    end

    M.unload(mod)

    if config == nil then
        return pcall(plugin.setup)
    else
        return pcall(plugin.setup, config)
    end
end

function M.load(mod, config)
    config = config or M.resolve_config(mod)

    if type(config) == 'function' then
        return pcall(config)
    end

    if type(config) == 'table' or type(config) == 'nil' then
        return attempt_plugin_setup(mod, config)
    end

    error('Invalid config for: "' .. mod .. '".')
end

return M
