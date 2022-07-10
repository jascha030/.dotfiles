local M = {}

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
