local M = {}

function M.defaults()
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

    return defaults
end

--- @type ConfigOptions
M.options = {}

function M.extend(options)
    if type(options) == 'table' then
        M.options = vim.tbl_deep_extend('force', M.options(), options)
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
