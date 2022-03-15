local M = {}

local spaces = require("hs._asm.undocumented.spaces")

M.move = function(application, space, mainScreen, builtInScreen)
	local win = nil

	while win == nil do
		win = application:mainWindow()
	end

	local fullScreen = not win:isStandard()

	local winFrame = win:frame()
	local scrFrame = mainScreen:fullFrame()

	local widthFactor = 2

	if builtInScreen ~= nil then
		if mainScreen:name() == builtInScreen then
			widthFactor = 3
		end
	end

	-- Center window if not snapped left or right
	if
		scrFrame.x ~= winFrame.x
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
		hs.eventtap.keyStroke("cmd", "return", 0, application)
	end

	win:focus()
end

return M
