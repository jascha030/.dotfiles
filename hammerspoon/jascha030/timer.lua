local M = {}

function M.create(msg)
    msg = msg or 'Wissel van houding.'

    local half_hour = 60 * 30

    local timer = hs.timer.new(half_hour, function()
        hs.alert.show(msg)
    end)

    return timer
end

return M
