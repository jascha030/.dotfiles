local spaces = require("hs._asm.undocumented.spaces")
local utils = require("utils")

local toggle = function(appName, screen)
	local instance = hs.application.get(appName)

	if instance ~= nil and instance:isFrontmost() then
		instance:hide()
	else
		local space = spaces.activeSpace()
		local mainScreen = hs.screen.find(spaces.mainScreenUUID())

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
	alacritty = require("term.alacritty"),
}
