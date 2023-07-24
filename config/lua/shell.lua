local M = {}

function M.shell_exec_multiline(input)
    local output = {}
    local c = 1

    io.stdout:setvbuf('no')
    local file = assert(io.popen(input, 'r'))
    file:flush()

    for line in file:lines('*a') do
        output[c] = line
        c = c + 1
    end

    local status = { file:close() }

    return output, status[3]
end

function M.shell_exec(input)
    io.stdout:setvbuf('no')

    local file = assert(io.popen(input, 'r'))
    local output = assert(file:read('*a'))
    local status = { file:close() }

    return output, status[3]
end

return M
