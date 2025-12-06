local M = {}

---@param tbl table
---@return boolean
function M.tbl_empty(tbl)
    local next = next

    return next(tbl) == nil
end

---@param callback function
---@param args any
---@return any
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

---@param path string
---@return boolean
function M.file_exists(path)
    local f = io.open(path, 'r')

    if f == nil then
        return false
    end

    io.close(f)

    return true
end

return M
