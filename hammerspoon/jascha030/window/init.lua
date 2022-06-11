local WindowManager = require('jascha030.window.manager')

local function create_manager(division, factor)
    return WindowManager:new(nil, division or 4, factor or 2)
end

return {
    -- Default Manager object.
    manager = WindowManager:new(nil, 4, 2),
    create = create_manager,
}
