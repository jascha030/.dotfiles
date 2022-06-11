local windowManager = require('jascha030.window').manager

local function toggle(appName, builtinScreen)
    local instance = hs.application.get(appName)

    if instance ~= nil and instance:isFrontmost() then
        instance:hide()
    else
        local mainScreen = hs.screen.mainScreen()
        local space = hs.spaces.activeSpaceOnScreen(mainScreen)

        if instance == nil and hs.application.launchOrFocus(appName) then
            local appWatcher = nil

            appWatcher = hs.application.watcher.new(function(name, event, app)
                if event == hs.application.watcher.launched and name == appName then
                    app:hide()

                    windowManager:move(app, space, builtinScreen)
                    appWatcher:stop()
                end
            end)

            appWatcher:start()
        end

        if instance ~= nil then
            windowManager:move(instance, space, builtinScreen)
        end
    end
end

return {
    toggle = toggle,
}

