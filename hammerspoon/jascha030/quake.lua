local M = {}

local window = nil

function M.toggle(app_name)
    local instance = hs.application.get(app_name)

    if window == nil then
        window = require('jascha030').window
    end

    if instance ~= nil and instance:isFrontmost() then
        instance:hide()
    else
        -- local main_screen = hs.screen.mainScreen()
        local main_screen = hs.mouse.getCurrentScreen()
        local space = hs.spaces.activeSpaceOnScreen(main_screen)

        if instance == nil and hs.application.launchOrFocus(app_name) then
            local app_watcher = nil

            app_watcher = hs.application.watcher.new(function(name, event, app)
                if event == hs.application.watcher.launched and name == app_name then
                    app:hide()

                    window.move(app, space)
                    app_watcher:stop()
                end
            end)

            app_watcher:start()
        end

        if instance ~= nil then
            window.move(instance, space)
        end
    end
end

function M.set(app)
    require('jascha030.tap').action = function()
        M.toggle(app)
    end
end

return M
