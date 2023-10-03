--- @class Utils
--- @field public fs FilesystemHelpers
--- @field public keymaps KeymapsUtil
--- @field public opts OptsUtil
--- @field public tbl TableHelpers 
--- @field public theme ThemeUtil
local M = {}

---@param plugin string
---@return boolean
function M.has_plugin(plugin)
	return require('lazy.core.config').spec.plugins[plugin] ~= nil
end

function M.wrap(fnc, ...)
    local params = { ... }

    if type(fnc) ~= 'function' then
        local prev = fnc
        fnc = function(...)
            return prev
        end
    end

    return function()
        return fnc(unpack(params))
    end
end

local function safe_load(m)
    return pcall(require, m)
end

function M.check_deps(list)
    for _, v in ipairs(list) do
        if not safe_load(v) then
            return false, v
        end
    end

    return true, list
end

function M.validate(list, where)
    local ok, v = M.check_deps(list)
    if not ok then
        error('Error initializing ' .. where .. ': missing dependency: "' .. v .. '.')
    end

    return ok
end

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

function M.get_width()
    return vim.api.nvim_list_uis()[1].width
end

function M.get_height()
    return vim.api.nvim_list_uis()[1].height
end

return setmetatable(M, {
    __index = function (_, k)
        local ok, mod = pcall(require, 'jascha030.utils.' .. k)

        return ok and mod or nil
    end
})
