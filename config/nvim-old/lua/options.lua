local user_config = nil

local config = {
    options = {},
    global = {},
    buffer = {},
    window = {},
}

local scopes = {
    g = vim.g,
    o = vim.o,
    b = vim.bo,
    w = vim.wo,
    opt = vim.opt,
}

local function set_from_config(option_scopes, options)
    for option_scope, option_list in pairs(options) do
        for option_key, option_value in pairs(option_list) do
            option_scopes[option_scope][option_key] = option_value
        end
    end
end

local M = {}

function M.setup(settings)
    settings = vim.tbl_deep_extend('force', config, settings or {})

    user_config = {
        o = settings.options,
        g = settings.global,
        b = settings.buffer,
        w = settings.window,
    }

    set_from_config(scopes, user_config)
end

return M
