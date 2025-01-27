---@alias jascha030.core.config.PathConfigOption string[]|table{path: string, prepend: boolean}
---@alias jascha030.core.config.PathConfigOptionType "env"|"rtp"

---@class jascha030.core.config.PathConfigOptions
---@field env? jascha030.core.config.PathConfigOption[]
---@field rtp? jascha030.core.config.PathConfigOption[]

---@class jascha030.core.config.VimConfigOptions
---@field g? table
---@field o? table
---@field opt? table

---@class jascha030.core.config.KeymapConfigOptions
---@field i? table
---@field n? table
---@field t? table
---@field v? table

---@class jascha030.core.config
---@field options jascha030.core.config.ConfigOptions
---@diagnostic disable-next-line: missing-fields
local M = { options = {} }

---@return jascha030.core.config.ConfigOptions
function M.defaults()
    return {
        colorscheme = false,
        debug = false,
        keymaps = { n = {}, v = {}, t = {}, i = {} },
        opts = { g = { mapleader = [[ ]] }, opt = {}, o = {} },
        path = { env = {}, rtp = {} },
        polyglot = { enabled = false, languages = {} },
        augroups = {},
    }
end

function M.extend(options)
    if type(options) == 'table' then
        M.options = vim.tbl_deep_extend('force', M.options, options)
    end
end

function M.get(key)
    return M.options[key] or nil
end

function M.setup(options)
    options = options or {}

    if type(options) == 'table' then
        M.options = vim.tbl_deep_extend('force', {}, M.defaults(), options or {})
    end
end

return M
