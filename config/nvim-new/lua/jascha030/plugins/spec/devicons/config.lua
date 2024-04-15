---@class IconConfig
local defaults = {
    default_icon = nil,
    icons = {},
    overrides = {},
}

---@class IconsModule
---@field public options IconConfig
local M = { devicons = {} }

local lreq = require('jascha030.lreq')
local devicons = lreq('nvim-web-devicons')

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

-- @field public options IconConfig
M.options = {}

function M.init()
    ---@diagnostic disable-next-line: undefined-field, need-check-nil
    devicons.refresh()
    devicons.set_icon(M.devicons)
end

function M.setup(options)
    M.options = vim.tbl_deep_extend('force', defaults, options)

    for name, devicon in pairs(M.options.overrides) do
        M.add(devicon.icon, name, devicon.filetypes)
    end

    M.devicons = vim.tbl_deep_extend('force', require('jascha030.plugins.spec.devicons.defaults'), M.devicons)

    devicons.setup(M.options)
    M.init()
end

return M
