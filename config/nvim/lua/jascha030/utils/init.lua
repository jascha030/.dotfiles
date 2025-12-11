---@diagnostic disable: duplicate-set-field
---
--- @class Utils
--- @field public theme ThemeUtil
local M = {}

function M.create_submod_loader(module, bind)
    return function(table, key)
        local ok, submod = pcall(require, module .. '.' .. key)

        if not ok then
            return nil
        end

        if bind == true then
            table[key] = submod

            return table[key]
        end

        return submod
    end
end

M = setmetatable(M, { __index = M.create_submod_loader('jascha030.utils') })

---@param plugin string
---@return boolean
function M.has_plugin(plugin)
    return require('lazy.core.config').spec.plugins[plugin] ~= nil
end

---@param fnc function|string
---@param ... any
---@return function
function M.wrap(fnc, ...)
    local params = { ... }

    if type(fnc) ~= 'function' then
        local prev = fnc
        -- stylua: ignore
        fnc = function(...) return prev end --- @diagnostic disable-line: unused-vararg
    end

    return function()
        return fnc(unpack(params))
    end
end

---@param m string
local function safe_load(m)
    return pcall(require, m)
end

---@param list string[]
---@return boolean, string[]|string
function M.check_deps(list)
    for _, v in ipairs(list) do
        if not safe_load(v) then
            return false, v
        end
    end

    return true, list
end

---@param list string[]
---@param where string
---@return boolean
function M.validate(list, where)
    local ok, v = M.check_deps(list)
    if not ok then
        error('Error initializing ' .. where .. ': missing dependency: "' .. v .. '.')
    end

    return ok
end

---@param delimiter string
---@param p string
---@return string[]
function M.str_explode(delimiter, p)
    local tbl, position = {}, 0

    if #p == 1 then
        return { p }
    end

    while true do
        local l = string.find(p, delimiter, position, true)

        if l ~= nil then
            table.insert(tbl, string.sub(p, position, l - 1))
            position = l + 1
        else
            table.insert(tbl, string.sub(p, position))
            break
        end
    end

    return tbl
end

---@return integer
function M.get_width()
    return vim.api.nvim_list_uis()[1].width
end

---@return integer
function M.get_height()
    return vim.api.nvim_list_uis()[1].height
end

return M
