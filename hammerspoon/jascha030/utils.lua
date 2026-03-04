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
function M.path_exists(path)
    local attr, _ = hs.fs.attributes(path)

    return attr ~= nil
end

---@param path string
---@return boolean
function M.is_file(path)
    local attr, _ = hs.fs.attributes(path)

    return attr ~= nil and attr.mode == 'file'
end

---@param path string
---@return boolean
function M.is_dir(path)
    local attr, _ = hs.fs.attributes(path)

    return attr ~= nil and attr.mode == 'directory'
end

---@return string
function M.read_file(path)
    if not M.is_file(path) then
        error('The provided path is not a file: ' .. path)
    end

    local file = io.open(path, 'r')

    if not file then
        error('Failed to open file: ' .. path)
    end

    local content = file:read('*a')
    file:close()

    return content
end

---@param path string
---@param content string
---@param append? boolean
---@return boolean
function M.write_file(path, content, append)
    local mode = append and 'a' or 'w'

    if not M.is_file(path) then
        local ok, err = hs.fs.touch(path)

        if not ok then
            print('Error:', err)
        end
    end

    local file = io.open(path, mode)

    if file == nil then
        error('Failed to open file for writing: ' .. path)
    end

    file:write(content)
    file:close()

    return true
end

return M
