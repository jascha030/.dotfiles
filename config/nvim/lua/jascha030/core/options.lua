---@alias jascha030.core.options.Scope "g"|"o"|"b"|"bo"|"w"|"wo"|"opt"

local scopes = {
    g = vim.g,
    o = vim.o,
    b = vim.bo,
    bo = vim.bo,
    w = vim.wo,
    wo = vim.wo,
    opt = vim.opt,
}

local M = {}

---@param key string
---@param val any 
---@param scope jascha030.core.options.Scope
function M.set_opt(key, val, scope)
    scopes[scope][key] = val
end

---@param options table{[jascha030.core.options.Scope]: table}
function M.set_opts(options)
    for scope, opts in pairs(options) do
        for o, v in pairs(opts) do
            M.set_opt(o, v, scope)
        end
    end
end

return M
