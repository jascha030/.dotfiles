local M = {}
local loaded = false

function M.fn(f, ...)
    local v = { ... }

    if type(f) ~= 'function' then
        local prev = f

        f = function(...)
            return prev
        end
    end

    return function()
        local ok, res = pcall(f, v)

        return ok and res
    end
end

function M.toggle_darkmode()
    hs.osascript.applescript([[
        tell application "System Events"
            tell appearance preferences
    	        set dark mode to not dark mode
			end tell
        end tell
    ]])
end

function M.setup(config)
    if loaded == true then
        return
    end

    loaded = true

    require('hs.ipc')
    hs.ipc.cliInstall()

    hs.window.setShadows(false)
    hs.window.animationDuration = 0

    for _, sp in pairs(config.spoons.load) do
        hs.loadSpoon(sp)
    end

    spoon.SpoonInstall:andUse('RoundedCorners', {
        start = true,
        config = { radius = 8 },
    })

    spoon.ReloadConfiguration:start()

    require('jascha030.quake').set(config.term_app)
    require('jascha030.hotkey').setup(config.hotkeys)
    hs.alert.show('🔨🥄 load done.')
end

return setmetatable(M, {
    __index = function(_, key)
        local ok, submodule = pcall(require, 'jascha030.' .. key)

        if not ok then
            error('Unknown module "' .. key .. '"')
        end

        return submodule
    end,
})
