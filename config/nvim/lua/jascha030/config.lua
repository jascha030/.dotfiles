local M = {}

--- @class ConfigOptions
local defaults = {
    colorscheme = false,
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
    devicons = {
        icons = require('jascha030.config.icons').get_icons(),
        overrides = {},
    },
}

--- @type ConfigOptions
M.options = {}

function M.setup(options)
    if type(options) == 'table' then
        M.options = vim.tbl_deep_extend('force', {}, defaults, options or {})
    end
end

function M.extend(options)
    if type(options) == 'table' then
        M.options = vim.tbl_deep_extend('force', M.options, options)
    end
end

return M
