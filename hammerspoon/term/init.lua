local spaces = require('hs.spaces')
local utils = require('utils')

local toggle = function(appName, screen)
    local instance = hs.application.get(appName)

    if instance ~= nil and instance:isFrontmost() then
        instance:hide()
    else
        --local mainScreen = hs.screen.find(spaces.mainScreenUUID())
        local mainScreen = hs.screen.mainScreen()
        local space = hs.spaces.activeSpaceOnScreen(mainScreen)

        if instance == nil and hs.application.launchOrFocus(appName) then
            local appWatcher = nil

            appWatcher = hs.application.watcher.new(function(name, event, app)
                if event == hs.application.watcher.launched and name == appName then
                    app:hide()

                    utils.window.move(app, space, mainScreen, screen)
                    appWatcher:stop()
                end
            end)

            appWatcher:start()
        end

        if instance ~= nil then
            utils.window.move(instance, space, mainScreen, screen)
        end
    end
end

return {
    toggle = toggle,
    alacritty = require('term.alacritty'),
}
