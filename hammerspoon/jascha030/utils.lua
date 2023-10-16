local M = {}

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
