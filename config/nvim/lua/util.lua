local M = {}

local function value_index(table)
    local set = {}

    for _, v in ipairs(table) do
        set[v] = true
    end

    return set
end

local function count(table)
    local count = 0

    for _, _ in ipairs(table) do
        count = count + 1
    end

    return count
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
    local ok, _ = pcall(require, m)

    return ok
end

function M.check_deps(list)
    for _, v in ipairs(list) do
        if not safe_load(v) then
            return false, v
        end
    end

    return true, list
end

return M
