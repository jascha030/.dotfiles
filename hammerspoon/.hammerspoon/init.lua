local spaces = require("hs._asm.undocumented.spaces")
local doubleTap = require("doubleTap")
local utils = require("utils")
local settings = require("settings")

settings:setup({})

doubleTap.action = function ()
  local APP_NAME = settings:get('termApp')

  function moveWindow(alacritty, space, mainScreen)
    local win = nil

    while win == nil do
      win = alacritty:mainWindow()
    end

    local fullScreen = not win:isStandard()

    -- if fullScreen then
    -- hs.eventtap.keyStroke('cmd', 'return', 0, alacritty)
    -- end

    winFrame = win:frame()
    scrFrame = mainScreen:fullFrame()

    local widthFactor = 2
    local builtInScreen = settings:get('builtinScreen')

    if builtInScreen ~= nil then
      if mainScreen:name() == builtInScreen then
        widthFactor = 3
      end
    end

    -- Center window if not snapped left or right
    if  scrFrame.x ~= winFrame.x
        and scrFrame.y ~= winFrame.y
        and scrFrame.x2 ~= winFrame.x2
        and scrFrame.y2 ~= winFrame.y2
    then
      winFrame.h = (scrFrame.h / 3) * 2
      winFrame.w = (scrFrame.w / 4) * widthFactor

      winFrame.y = (scrFrame.y2 / 2) - (winFrame.h / 2)
      winFrame.x = (scrFrame.x2 / 2) - (winFrame.w / 2)
    end

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

  hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(window, appName)
    local alacritty = hs.application.get(settings:get('termApp'))

    -- if alacritty ~= nil then
    -- uncomment to unfocus
    -- alacritty:hide()
    -- end
  end)
end

