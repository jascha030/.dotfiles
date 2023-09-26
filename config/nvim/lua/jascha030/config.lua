-- @class ConfigOptions
local M = {}

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
        icons = require('jascha030.config.icons'),
        overrides = {},
    },
}

M.options = {}

function M.setup(options)
    M.options = vim.tbl_deep_extend('force', {}, defaults, options or {})
end

return M
