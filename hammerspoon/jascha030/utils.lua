local M = {}

local function value_index(table)
    local set = {}

    for _, v in ipairs(table) do
        set[v] = true
    end

    return set
end

local function key_index(table)
    local set = {}

    for k, _ in ipairs(table) do
        set[k] = true
    end

    return set
end

function M.tbl_contains(t, v)
    local map = value_index(t)

    return map[v] or false
end

function M.compare_keys(t1, t2, keys)
    keys = keys == nil and key_index(t1) or value_index(keys)

    for k, _ in ipairs(keys) do
        keys[k] = t1[k] == t2[k]
    end

    return keys
end

function M.table_merge(t1, t2)
    for k, v in pairs(t2) do
        if type(v) == 'table' then
            if type(t1[k] or false) == 'table' then
                M.table_merge(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end

    return t1
end

function M.alert(callback, args)
    args = args or nil

    hs.alert.closeAll()

    local ok, res = pcall(callback, args)

    if not ok then
        hs.alert('The alert callback caused an unexpected error.')
    end

    if res ~= nil then
        return res
    end
end

function M.file_exists(path)
    local f = io.open(path, 'r')

    if f == nil then
        return false
    end

    io.close(f)

    return true
end

return M
