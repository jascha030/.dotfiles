---@diagnostic disable: undefined-doc-name

---@class JSpoon.QuakeModule
---@field app_name string
---@field get_app_name fun(self): string
---@field get_instance fun(self): hs.application
---@field get_observer fun(self, app_watcher: hs.application.watcher, space: hs.screen.space): fun(name: string, event: number, app: hs.application)
---@field toggle fun(self)
---@field set fun(app: table)
local M = {}
local window = {}
local alt_active = false

window = setmetatable(window, {
    __index = function(_, k)
        local next = next

        if next(window) == nil then
            window = require('jascha030').window
        end

        return window[k]
    end,
})

---@param app_name string
---@return JSpoon.QuakeModule
function M.new(app_name)
    return setmetatable({ app_name = app_name }, { __index = M })
end

---@return string
function M:get_app_name()
    return self.app_name
end

---@return hs.application?
function M:get_instance()
    return hs.application.find(self:get_app_name(), true)
end

---@param app_watcher hs.application.watcher
---@param space hs.screen.space
function M:get_observer(app_watcher, space)
    local app_name = self:get_app_name()

    return function(name, event, app)
        if event == hs.application.watcher.launched and name == app_name then
            app:hide()
            hs.timer.waitUntil(
                function()
                    return app:mainWindow()
                end,
                function()
                    window.move(app, space)
                end,
                0.1
            )

            if app_watcher ~= nil then
                app_watcher:stop()
            end
        end
    end
end

---@param app hs.application
---@return boolean
local function isFrontmost(app)
    local isFront, ok = pcall(app.isFrontmost, app)

    return ok and isFront
end

function M:toggle()
    local app_name = self:get_app_name()
    local instance = self:get_instance()

    if instance ~= nil and isFrontmost(instance) then
        if not (self:get_app_name() == 'Ghostty' and #instance:allWindows() == 0) then
            instance:hide()
            return
        end

        hs.eventtap.keyStroke({ 'cmd' }, 'n', nil, instance)
    else
        local main_screen = hs.mouse.getCurrentScreen()
        local space = hs.spaces.activeSpaceOnScreen(main_screen)

        -- This is just when the app is not running.
        if instance == nil and hs.application.launchOrFocus(app_name) then
            local app_watcher = nil

            ---@diagnostic disable-next-line: param-type-mismatch
            app_watcher = hs.application.watcher.new(self:get_observer(app_watcher, space))
            app_watcher:start()

            return
        end

        if instance ~= nil then
            if #instance:allWindows() == 0 then
                hs.eventtap.keyStroke({ 'cmd' }, 'n', nil, instance)

                hs.timer.waitUntil(
                    function()
                        return instance:mainWindow()
                    end,
                    function()
                        window.move(instance, space)
                    end,
                    0.1
                )
            else
                window.move(instance, space)
            end
        end
    end
end

---@param app_name string
---@param alt_app_name string
local function handler_factory(app_name, alt_app_name)
    local instance = M.new(app_name)
    local alt_instance = M.new(alt_app_name)

    return function()
        if alt_active then
            alt_instance:toggle()
        else
            instance:toggle()
        end
    end
end

function M.toggle_alt()
    alt_active = not alt_active

    hs.alert(alt_active and 'Quake mapped to: Ghostty' or 'Quake mapped to: WezTerm')
end

---@param apps table{main: string, alt: string}
function M.set(apps)
    require('jascha030.tap').action = handler_factory(apps.main, apps.alt)
end

return M
