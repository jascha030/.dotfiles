--- @class ConfigOptions
local defaults = {
    colorscheme = false,
    polyglot = {
        enabled = false,
        languages = {},
    },
    keymaps = {
        n = {},
        v = {},
        t = {},
        i = {},
    },
    opts = {
        g = {
            mapleader = [[ ]],
        },
        opt = {},
    },
}

local M = {}

--- @type ConfigOptions
M.options = setmetatable({}, { __index = defaults })

function M.extend(options)
    if type(options) == 'table' then
        M.options = vim.tbl_deep_extend('force', M.options, options)
    end
end

function M.get(key)
    return M.options[key] or nil
end

function M.setup(options)
    if type(options) == 'table' then
        M.options = vim.tbl_deep_extend('force', {}, defaults, options or {})
    end
end

return M
