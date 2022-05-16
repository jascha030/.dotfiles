local M = {}

M.tbl_merge = function(t1, t2)
    for _, v in ipairs(t2) do
        table.insert(t1, v)
    end

    return t1
end

return M
