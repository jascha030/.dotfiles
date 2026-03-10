local deadlines_file = os.getenv('HOME') .. '/.hammerspoon/deadlines.json'
local json = hs.json
local menubar = hs.menubar.new()
local utils = require('jascha030.utils')

if menubar == nil then
    error("Couldn't init menubar")
end

---@param path? string
---@return table
local function load_deadlines(path)
    path = path or deadlines_file
    local content = utils.read_file(path)

    if not content then
        return {}
    end

    return json.decode(content) or {}
end

---@param date_str string
---@return integer
local function days_until(date_str)
    local y, m, d = date_str:match('(%d+)%-(%d+)%-(%d+)')
    local deadline = os.time({ year = y, month = m, day = d, hour = 0 })
    return math.floor((deadline - os.time()) / 86400)
end

local M = {}
function M.updateMenu()
    print('updateing deadlines menu')
    local deadlines = load_deadlines()

    table.sort(deadlines, function(a, b)
        return days_until(a.date) < days_until(b.date)
    end)

    if #deadlines == 0 then
        menubar:setTitle('No deadlines')
        return
    end

    local nextDeadline = deadlines[1]
    local days = days_until(nextDeadline.date)
    menubar:setTitle('⏳ ' .. days .. 'd')

    local menu = {}

    for _, d in ipairs(deadlines) do
        table.insert(menu, {
            title = d.name .. ': ' .. days_until(d.date) .. 'd',
        })
    end

    table.insert(menu, { title = '-' })
    table.insert(menu, {
        title = 'Edit Deadlines',
        fn = function()
            hs.execute('open ' .. deadlines_file)
        end,
    })

    menubar:setMenu(menu)
end

local init = false
local timer = nil

function M.init()
    if not init then
        M.updateMenu()
        timer = hs.timer.doEvery(600, M.updateMenu)

        init = true
    end
end

return M
