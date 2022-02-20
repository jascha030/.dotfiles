local spaces = require("hs._asm.undocumented.spaces")
local doubleTap = require("doubleTap")
local utils = require("utils")
local settings = require("settings")

settings:setup({})

doubleTap.action = function ()
  local APP_NAME = settings:get('termApp')
  local termApp = hs.application.get(APP_NAME)
  local builtinScreen = settings:get('builtInScreen')

  if termApp ~= nil and termApp:isFrontmost() then
    termApp:hide()
  else
    local space = spaces.activeSpace()
    local mainScreen = hs.screen.find(spaces.mainScreenUUID())

    if termApp == nil and hs.application.launchOrFocus(APP_NAME) then
      local appWatcher = nil

      appWatcher = hs.application.watcher.new(function(name, event, app)
        if event == hs.application.watcher.launched and name == APP_NAME then
          app:hide()

          utils.window.move(app, space, mainScreen, builtinScreen)
          appWatcher:stop()
        end
      end)

      appWatcher:start()
    end

    if termApp ~= nil then
      utils.window.move(termApp, space, mainScreen, builtinScreen)
    end
  end

  -- hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(window, appName)
    -- local termApp = hs.application.get(termApp)
    -- if termApp ~= nil then
    -- uncomment to unfocus
    -- termApp:hide()
    -- end
  -- end)
end

