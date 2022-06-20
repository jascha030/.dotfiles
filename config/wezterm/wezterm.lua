local wezterm = require('wezterm')
local theme = require('theme')
local fonts = require('fonts')

wezterm.on('window-config-reloaded', function(window, pane)
    local overrides = window:get_config_overrides() or {}
    local scheme = theme.get_scheme(window:get_appearance())

    if overrides.colors ~= scheme then
        overrides.colors = scheme
        window:set_config_overrides(overrides)
    end
end)

local keys = {
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    { key = 's', mods = 'LEADER', action = wezterm.action({ SplitVertical = { domain = 'CurrentPaneDomain' } }) },
    { key = 'v', mods = 'LEADER', action = wezterm.action({ SplitHorizontal = { domain = 'CurrentPaneDomain' } }) },
    { key = 'z', mods = 'LEADER', action = 'TogglePaneZoomState' },
    { key = 'c', mods = 'LEADER', action = wezterm.action({ SpawnTab = 'CurrentPaneDomain' }) },
    { key = 'j', mods = 'LEADER', action = wezterm.action({ ActivatePaneDirection = 'Prev' }) },
    { key = 'l', mods = 'LEADER', action = 'ActivateLastTab' },
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
    { key = '&', mods = 'LEADER|SHIFT', action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
    { key = 'x', mods = 'LEADER', action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },

    { key = 'n', mods = 'SHIFT|CTRL', action = 'ToggleFullScreen' },
    { key = 'v', mods = 'SHIFT|CTRL', action = 'Paste' },
    { key = 'c', mods = 'SHIFT|CTRL', action = 'Copy' },
}

--local leader_key = function()
--    return os.getenv('TERMINAL_PROGRAM') == 'tmux' and 'b' or 'd'
--end

local leader_mod = 'CTRL'

if os.getenv('TERM_PROGRAM') == 'tmux' then
    leader_mod = 'CTRL|SHIFT'
end

return {
    default_prog = { '/usr/local/bin/zsh', '--login' },

    leader = { key = 'd', mods = leader_mod },
    disable_default_key_bindings = true,

    keys = keys,

    enable_tab_bar = false,

    window_decorations = 'NONE | RESIZE',
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 },

    default_cursor_style = 'BlinkingBlock',

    cursor_blink_rate = 250,
    cursor_blink_ease_in = 'Ease',
    cursor_blink_ease_out = 'Ease',

    font_size = fonts.size,
    font = fonts.default,
    font_rules = fonts.rules,

    colors = theme.get_scheme('Dark'),
}
