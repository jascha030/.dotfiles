--@class IconConfig
--@field public default_icon string
local defaults = { icons = {}, overrides = {} }
--@class IconsModule
--@field public options IconConfig
local M = { devicons = {}, options = {} }

local devicons = nil

function M.get_icon(name)
    if not M.options.icons[name] then
        error('No icon defined for ' .. name)
    end
    return M.options.icons[name]
end

function M.create(icon, name)
    return { icon = M.get_icon(icon), name = name }
end

function M.add(icon, name, filetype)
    if type(filetype) == 'string' then
        M.devicons[filetype] = M.create(icon, name)
    end

    if type(filetype) == 'table' then
        for prefix, type in pairs(filetype) do
            M.add(icon, prefix .. name, type)
        end
    end
end

function M.setup(conf)
    if devicons == nil then
        devicons = require('nvim-web-devicons')
    end

    M.options = vim.tbl_deep_extend('force', {}, defaults, conf)

    devicons.setup({ default_icon = M.options.default_icon })

    for name, devicon in pairs(M.options.overrides) do
        M.add(devicon.icon, name, devicon.filetypes)
    end
    devicons.set_icon(M.devicons)
end

return M
