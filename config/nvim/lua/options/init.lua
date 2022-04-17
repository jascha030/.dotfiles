-- vim option scopes
local scopes = {
    g = vim.g,
    o = vim.o,
    b = vim.bo,
    w = vim.wo,
    opt = vim.opt,
}

--[[Functions]]
-- Set options per scope in a loop
local set_options_per_scope = function(option_scopes, options)
    for option_scope, option_list in pairs(options) do
        for option_key, option_value in pairs(option_list) do
            option_scopes[option_scope][option_key] = option_value
        end
    end
end

-- Set listed options from options module per scope
set_options_per_scope(scopes, require('options.config'))


