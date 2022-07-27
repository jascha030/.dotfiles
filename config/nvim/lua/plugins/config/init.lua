local function get_config_file(module)
    module = 'plugins.config.' .. module

    local ok, res = pcall(require, module)

    if not ok then
        error('Could not load plugin module: "' .. module .. '".')
    end

    return res
end

local function try_property(module, plugin)
    module = get_config_file(module)

    if not module[plugin] then
        error('Could not load plugin config: "' .. plugin .. '".')
    end

    return module[plugin]
end

function PluginConfig(module, plugin)
    plugin = plugin or nil

    if plugin == nil then
        return get_config_file(module)
    end

    local full_mod = 'plugins.config.' .. module .. '.' .. plugin

    local ok, res = pcall(require, full_mod)

    if not ok then
        return try_property(module, plugin)
    end

    return res
end
