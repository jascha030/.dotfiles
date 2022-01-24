local spaces = require("hs._asm.undocumented.spaces")
local doubleTap = require("doubleTap")

hs.application.enableSpotlightForNameSearches(true)

doubleTap.action = function ()
  local APP_NAME = 'Alacritty'

  function moveWindow(alacritty, space, mainScreen)
    local win = nil

    while win == nil do
      win = alacritty:mainWindow()
    end

    local fullScreen = not win:isStandard()

    if fullScreen then
      hs.eventtap.keyStroke('cmd', 'return', 0, alacritty)
    end

    winFrame = win:frame()
    scrFrame = mainScreen:fullFrame()

    win:setFrame(winFrame, 0)
    win:spacesMoveTo(space)

    if fullScreen then
      hs.eventtap.keyStroke('cmd', 'return', 0, alacritty)
    end

    win:focus()
  end

  local alacritty = hs.application.get(APP_NAME)

  if alacritty ~= nil and alacritty:isFrontmost() then
    alacritty:hide()
  else
    local space = spaces.activeSpace()
    local mainScreen = hs.screen.find(spaces.mainScreenUUID())

    if alacritty == nil and hs.application.launchOrFocus(APP_NAME) then
      local appWatcher = nil

      appWatcher = hs.application.watcher.new(function(name, event, app)

        if event == hs.application.watcher.launched and name == APP_NAME then
          app:hide()
          moveWindow(app, space, mainScreen)
          appWatcher:stop()
        end
      end)


      appWatcher:start()
    end
    if alacritty ~= nil then
      moveWindow(alacritty, space, mainScreen)
    end
  end
end

hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(window, appName)
  local alacritty = hs.application.get('Alacritty')
  if alacritty ~= nil then
     alacritty:hide()
  end
end)

