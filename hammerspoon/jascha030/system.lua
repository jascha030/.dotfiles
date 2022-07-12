local M = {}

function M.toggleDark()
    hs.osascript.applescript([[
        tell application "System Events"
	        tell appearance preferences
		        set dark mode to not dark mode
			end tell
	    end tell
    ]])
end

return M
