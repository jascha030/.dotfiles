local config = {
    utils = require('plugins.config.utils'),
    lsp = require('plugins.config.lsp'),
    ui = require('plugins.config.ui'),
}

local function get_config_file(module)
    local ok, res = pcall('require', 'plugins.config.' .. module)

    if not ok then
        error('Could not load plugin module: "' .. module .. '".')
    end

    return res
end

function PluginConfig(module, plugin)
    plugin = plugin or nil

    if plugin == nil then
        return get_config_file(module)
    end

    local ok, res = pcall('require', 'plugins.config.' .. module .. '.' .. plugin)

    if not ok then
        error('Could not load plugin config: "' .. plugin .. '".')
    end

    return res
end

return config
