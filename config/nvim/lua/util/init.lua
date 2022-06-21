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

return M
