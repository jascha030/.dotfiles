local term = require('quake.term')
local tap = require('quake.tap')

-- DoubleTap
--    key = cmd,
--    map = term.toggle
local function set(app, screen)
    tap.action = function()
        term.toggle(app, screen)
    end
end

return {
    set = set,
}
