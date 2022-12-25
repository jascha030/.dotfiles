local Utils = {}

local cmds_loaded = false

function Utils.wrap(fnc, ...)
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
    local ok, res = pcall(require, m)

    return ok, res
end

function Utils.check_deps(list)
    for _, v in ipairs(list) do
        if not safe_load(v) then
            return false, v
        end
    end

    return true, list
end

function Utils.validate(list, where)
    local ok, v = Utils.check_deps(list)

    if not ok then
        error('Error initializing ' .. where .. ': missing dependency: "' .. v .. '.')
    end

    return ok
end

function Utils.str_explode(delimiter, p)
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

-- local install_path = ('%s/site/pack/packer-lib/opt/packer.nvim'):format(vim.fn.stdpath('data'))

function Utils.get_width()
    return vim.api.nvim_list_uis()[1].width
end

function Utils.get_height()
    return vim.api.nvim_list_uis()[1].height
end

Utils = setmetatable(Utils, {
    __index = function(_, key)
        local ok, submod = pcall(require, 'utils.' .. key)

        return ok and submod or nil
    end,
})

return Utils
