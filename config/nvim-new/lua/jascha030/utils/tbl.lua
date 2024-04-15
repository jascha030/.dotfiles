--- @class TableHelpers
local M = {}

function M.tbl_count(table)
    local _count = 0

    for _, _ in ipairs(table) do
        _count = _count + 1
    end

    return _count
end

function M.tbl_length(t)
    assert(t == nil or type(t) == 'table', 'bad parameter #1: must be of type table or nil.')

    if t == nil then
        return 0
    end

    return M.tbl_count(t)
end

return M
