local M = {}
local window = {}

window = setmetatable(window, { __index = function(_, k)
    local next = next

    if next(window) == nil then
        window = require('jascha030').window
    end

    return window[k]
end})

function M.new(app_name)
    return setmetatable({ app_name = app_name }, { __index = M })
end

---@return string
function M:get_app_name()
    return self.app_name
end

function M:get_instance()
    return hs.application.get(self:get_app_name())
end

function M:get_observer(app_watcher, space)
    local app_name = self:get_app_name()

    return function(name, event, app)
        if event == hs.application.watcher.launched and name == app_name then
            app:hide()
            window.move(app, space)

            if app_watcher ~= nil then
                app_watcher:stop()
            end
        end
    end
end

function M:toggle()
    local app_name = self:get_app_name()
    local instance = self:get_instance()

    if instance ~= nil and instance:isFrontmost() then
        instance:hide()
    else
        -- if instance ~= nil and instance:isHidden() then
        --     instance:unhide()
        -- end

        local main_screen = hs.mouse.getCurrentScreen()
        local space = hs.spaces.activeSpaceOnScreen(main_screen)

        if instance == nil and hs.application.launchOrFocus(app_name) then
            local app_watcher = nil

            app_watcher = hs.application.watcher.new(self:get_observer(app_watcher, space))
            app_watcher:start()
        end

        if instance ~= nil then
            window.move(instance, space)
        end
    end
end

function M.set(app)
    local instance = M.new(app)

    require('jascha030.tap').action = function()
        instance:toggle()
    end
end

return M
