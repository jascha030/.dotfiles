local M = {}

local wezterm = require('wezterm')

---@param resize_or_move "resize" | "move"
---@param mods string
---@param key string
---@param dir string 'Right' | 'Left' | 'Up' | 'Down'
function M.split_nav(resize_or_move, mods, key, vimKey, dir)
    local event = 'SplitNav_' .. resize_or_move .. '_' .. dir

    wezterm.on(event, function(win, pane)
        if M.is_nvim(pane) then
            if type(vimKey) == 'string' then
                -- pass the keys through to vim/nvim
                win:perform_action({ SendKey = { key = 'w', mods = 'CTRL' } }, pane)
                win:perform_action({ SendKey = { key = vimKey } }, pane)
            end
        else
            if resize_or_move == 'resize' then
                win:perform_action({ AdjustPaneSize = { dir, 3 } }, pane)
            else
                local panes = pane:tab():panes_with_info()
                local is_zoomed = false

                for _, p in ipairs(panes) do
                    if p.is_zoomed then
                        is_zoomed = true
                    end
                end

                wezterm.log_info('is_zoomed: ' .. tostring(is_zoomed))

                if is_zoomed then
                    dir = (dir == 'Up' or dir == 'Right') and 'Next' or 'Prev'
                    wezterm.log_info('dir: ' .. dir)
                end

                win:perform_action({ ActivatePaneDirection = dir }, pane)
                win:perform_action({ SetPaneZoomState = is_zoomed }, pane)
            end
        end
    end)

    return {
        key = key,
        mods = mods,
        action = wezterm.action.EmitEvent(event),
    }
end

function M.is_nvim(pane)
    return pane:get_user_vars().IS_NVIM == 'true' or pane:get_foreground_process_name():find('n?vim')
end

return {
    { key = 'v', mods = 'CMD',    action = wezterm.action.PasteFrom('Clipboard') },
    { key = 'c', mods = 'CMD',    action = wezterm.action.CopyTo('ClipboardAndPrimarySelection') },
    { key = 's', mods = 'LEADER', action = wezterm.action({ SplitVertical = { domain = 'CurrentPaneDomain' } }) },
    { key = 'v', mods = 'LEADER', action = wezterm.action({ SplitHorizontal = { domain = 'CurrentPaneDomain' } }) },
    { key = 'g', mods = 'LEADER', action = wezterm.action.PaneSelect },
    {
        key = 'G',
        mods = 'LEADER',
        action = wezterm.action.PaneSelect({
            mode = 'SwapWithActive',
        })
    },
    M.split_nav('move', 'ALT', 'LeftArrow', 'h', 'Left'),
    M.split_nav('move', 'ALT', 'DownArrow', 'j', 'Down'),
    M.split_nav('move', 'ALT', 'UpArrow', 'k', 'Up'),
    M.split_nav('move', 'ALT', 'RightArrow', 'l', 'Right'),
    { key = 'l',          mods = 'LEADER',       action = 'ActivateLastTab' },
    { key = 'c',          mods = 'LEADER',       action = wezterm.action({ SpawnTab = 'CurrentPaneDomain' }) },
    { key = '&',          mods = 'LEADER|SHIFT', action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
    { key = 'x',          mods = 'LEADER',       action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
    { key = 'LeftArrow',  mods = 'LEADER|SHIFT', action = wezterm.action({ AdjustPaneSize = { 'Left', 5 } }) },
    { key = 'DownArrow',  mods = 'LEADER|SHIFT', action = wezterm.action({ AdjustPaneSize = { 'Down', 5 } }) },
    { key = 'UpArrow',    mods = 'LEADER|SHIFT', action = wezterm.action({ AdjustPaneSize = { 'Up', 5 } }) },
    { key = 'RightArrow', mods = 'LEADER|SHIFT', action = wezterm.action({ AdjustPaneSize = { 'Right', 5 } }) },
    { key = '1',          mods = 'LEADER',       action = wezterm.action({ ActivateTab = 0 }) },
    { key = '2',          mods = 'LEADER',       action = wezterm.action({ ActivateTab = 1 }) },
    { key = '3',          mods = 'LEADER',       action = wezterm.action({ ActivateTab = 2 }) },
    { key = '4',          mods = 'LEADER',       action = wezterm.action({ ActivateTab = 3 }) },
    { key = '5',          mods = 'LEADER',       action = wezterm.action({ ActivateTab = 4 }) },
    { key = '6',          mods = 'LEADER',       action = wezterm.action({ ActivateTab = 5 }) },
    { key = '7',          mods = 'LEADER',       action = wezterm.action({ ActivateTab = 6 }) },
    { key = '8',          mods = 'LEADER',       action = wezterm.action({ ActivateTab = 7 }) },
    { key = '9',          mods = 'LEADER',       action = wezterm.action({ ActivateTab = 8 }) },
    { key = ']',          mods = 'CMD',          action = wezterm.action.EmitEvent('opacity-up') },
    { key = '[',          mods = 'CMD',          action = wezterm.action.EmitEvent('opacity-down') },
    { key = '=',          mods = 'CMD',          action = wezterm.action.EmitEvent('font-size-up') },
    { key = '-',          mods = 'CMD',          action = wezterm.action.EmitEvent('font-size-down') },
    { key = 'p',          mods = 'CMD',          action = wezterm.action.EmitEvent('line-height-up') },
    { key = 'o',          mods = 'CMD',          action = wezterm.action.EmitEvent('line-height-down') },
    { key = '0',          mods = 'CMD',          action = wezterm.action.EmitEvent('reset-font') },
    { key = '9',          mods = 'CMD',          action = wezterm.action.EmitEvent('toggle-font') },
    { key = 'L',          mods = 'CMD',          action = wezterm.action.ShowDebugOverlay },
    { key = 'P',          mods = 'CMD',          action = wezterm.action.ActivateCommandPalette },
}
