local scopes = {
    g = vim.g,
    o = vim.o,
    b = vim.bo,
    bo = vim.bo,
    w = vim.wo,
    wo = vim.wo,
}

--- @class OptsUtil
local M = {}

function M.opt(key, val, scope)
    if not scope then
        vim.opt[key] = val
    else
        scopes[scope][key] = val
    end
end

function M.set_opts(options)
    for scope, opts in pairs(options) do
        for o, v in pairs(opts) do
            if scope == 'opt' then
                M.opt(o, v)
            else
                M.opt(o, v, scope)
            end
        end
    end
end

return M
