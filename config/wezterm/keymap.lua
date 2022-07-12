local wezterm = require('wezterm')
local fish_args = { args = { '/usr/local/bin/fish', '--login' }, cwd = os.getenv('HOME') }

return {
    { key = 'F', mods = 'LEADER|SHIFT', action = wezterm.action({ SpawnCommandInNewTab = fish_args }) },
    { key = 'n', mods = 'SHIFT|CTRL', action = 'ToggleFullScreen' },
    { key = 'v', mods = 'CMD', action = 'Paste' },
    { key = 'c', mods = 'CMD', action = 'Copy' },
    { key = 's', mods = 'LEADER', action = wezterm.action({ SplitVertical = { domain = 'CurrentPaneDomain' } }) },
    { key = 'v', mods = 'LEADER', action = wezterm.action({ SplitHorizontal = { domain = 'CurrentPaneDomain' } }) },

    { key = 'LeftArrow', mods = 'ALT', action = wezterm.action({ ActivatePaneDirection = 'Left' }) },
    { key = 'RightArrow', mods = 'ALT', action = wezterm.action({ ActivatePaneDirection = 'Right' }) },
    { key = 'UpArrow', mods = 'ALT', action = wezterm.action({ ActivatePaneDirection = 'Up' }) },
    { key = 'DownArrow', mods = 'ALT', action = wezterm.action({ ActivatePaneDirection = 'Down' }) },

    { key = 'l', mods = 'LEADER', action = 'ActivateLastTab' },
    { key = 'c', mods = 'LEADER', action = wezterm.action({ SpawnTab = 'CurrentPaneDomain' }) },
    { key = '&', mods = 'LEADER|SHIFT', action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
    { key = 'x', mods = 'LEADER', action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },

    { key = 'H', mods = 'LEADER|SHIFT', action = wezterm.action({ AdjustPaneSize = { 'Left', 5 } }) },
    { key = 'J', mods = 'LEADER|SHIFT', action = wezterm.action({ AdjustPaneSize = { 'Down', 5 } }) },
    { key = 'K', mods = 'LEADER|SHIFT', action = wezterm.action({ AdjustPaneSize = { 'Up', 5 } }) },
    { key = 'L', mods = 'LEADER|SHIFT', action = wezterm.action({ AdjustPaneSize = { 'Right', 5 } }) },

    { key = '1', mods = 'LEADER', action = wezterm.action({ ActivateTab = 0 }) },
    { key = '2', mods = 'LEADER', action = wezterm.action({ ActivateTab = 1 }) },
    { key = '3', mods = 'LEADER', action = wezterm.action({ ActivateTab = 2 }) },
    { key = '4', mods = 'LEADER', action = wezterm.action({ ActivateTab = 3 }) },
    { key = '5', mods = 'LEADER', action = wezterm.action({ ActivateTab = 4 }) },
    { key = '6', mods = 'LEADER', action = wezterm.action({ ActivateTab = 5 }) },
    { key = '7', mods = 'LEADER', action = wezterm.action({ ActivateTab = 6 }) },
    { key = '8', mods = 'LEADER', action = wezterm.action({ ActivateTab = 7 }) },
    { key = '9', mods = 'LEADER', action = wezterm.action({ ActivateTab = 8 }) },
}
