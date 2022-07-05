local WindowManager = require('jascha030.window.manager')

local function create_manager(division, factor)
    return WindowManager.create(division, factor)
end

return {
    _manager = WindowManager,
    manager = create_manager(),
    create_manager = create_manager,
}
