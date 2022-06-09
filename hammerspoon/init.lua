require('hs.ipc')

hs.ipc.cliInstall()

-- Globals and init.
hs.spoons.use('EmmyLua')

-- Global values
hs.window.setShadows(false)
hs.window.animationDuration = 0

-- Enables quake terminal.
--
-- Term app: Wezterm
-- Trigger: Double tap cmd
require('quake')

hs.loadSpoon("SpoonInstall")

