local window_manager = require('jascha030.window').manager

local function toggle(app_name, builtin_screen)
    local instance = hs.application.get(app_name)

    if instance ~= nil and instance:isFrontmost() then
        instance:hide()
    else
        local main_screen = hs.screen.mainScreen()
        local space = hs.spaces.activeSpaceOnScreen(main_screen)

        if instance == nil and hs.application.launchOrFocus(app_name) then
            local app_watcher = nil

            app_watcher = hs.application.watcher.new(function(name, event, app)
                if event == hs.application.watcher.launched and name == app_name then
                    app:hide()

                    window_manager:move(app, space, builtin_screen)
                    app_watcher:stop()
                end
            end)

            app_watcher:start()
        end

        if instance ~= nil then
            window_manager:move(instance, space, builtin_screen)
        end
    end
end

return {
    set = function(app, screen)
        require('jascha030.quake.tap').action = function()
            toggle(app, screen)
        end
    end,
    toggle = toggle
}
