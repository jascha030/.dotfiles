local M = {}

local function value_index(table)
    local set = {}
    for _, v in ipairs(table) do
        set[v] = true
    end

    return set
end

local function count(table)
    local _count = 0
    for _, _ in ipairs(table) do
        _count = _count + 1
    end

    return _count
end

function M.tbl_contains(t, v)
    local map = value_index(t)

    return map[v] or false
end

function M.tbl_length(t)
    assert(t == nil or type(t) == 'table', 'bad parameter #1: must be of type table or nil.')
    if t == nil then
        return 0
    end

    return count(t)
end

function M.tbl_merge(t1, t2)
    for _, v in ipairs(t2) do
        table.insert(t1, v)
    end

    return t1
end

function M.kmap(keymap, action, mode, opts)
    mode = mode or 'n'
    opts = opts or { noremap = true }

    vim.api.nvim_set_keymap(mode, keymap, action, opts)
end

local function safe_load(m)
    local ok, res = pcall(require, m)

    return ok, res
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

function M.cwd_in(where)
    return string.find(vim.fn.getcwd(), where) ~= nil
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

function M.data_dir()
    return string.format('%s/site/', vim.fn.stdpath('data'))
end

return M
