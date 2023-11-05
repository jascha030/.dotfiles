local scopes = {
    g = vim.g,
    o = vim.o,
    b = vim.bo,
    bo = vim.bo,
    w = vim.wo,
    wo = vim.wo,
    opt = vim.opt,
}

--- @class OptsUtil
local M = {}

function M.set_opt(key, val, scope)
    scopes[scope][key] = val
end

function M.set_opts(options)
    for scope, opts in pairs(options) do
        for o, v in pairs(opts) do
            M.set_opt(o, v, scope)
        end
    end
end

return M
