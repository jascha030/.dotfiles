local M = {
    devicons = {},
    defaults = {
        icons = {},
        colors = {},
        overrides = {},
    },
}

local config = nil

function M.get_icon(name)
    if not config.icons[name] then
        error('No icon defined for ' .. name)
    end

    return config.icons[name]
end

function M.create(icon, color, name)
    return {
        icon = M.get_icon(icon),
        color = config.colors[color] or color,
        name = name,
    }
end

function M.add(icon, color, name, filetype)
    if type(filetype) == 'string' then
        M.devicons[filetype] = M.create(icon, color, name)
    end

    if type(filetype) == 'table' then
        for prefix, type in pairs(filetype) do
            M.add(icon, color, prefix .. name, type)
        end
    end
end

function M.setup(conf)
    config = vim.tbl_deep_extend('force', M.defaults, conf)

    local devicons = require('nvim-web-devicons')

    devicons.setup({ default_icon = require('utils').conf.devicons.default_icon })

    for name, devicon in pairs(conf.overrides) do
        M.add(devicon.icon, devicon.color, name, devicon.filetypes)
    end

    devicons.set_icon(M.devicons)
end

return M
