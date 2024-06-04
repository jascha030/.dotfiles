local theme = require('theme')
local font = require('fonts')
local handlers = require('handlers')
local colors = theme.get_scheme('Dark', true)

font.extend({
    main = 'Cascadia Code',
    alt = 'Dank Mono',
    italic = 'Cascadia Code',
})

handlers.setup()

---Build padding object
---@param size number vertical padding
---@param alt number horizontal padding
---@param cell boolean|nil use unit: cell for padding.
---@return table
local function eq_pad(size, alt, cell)
    alt = alt or size
    cell = cell or false

    if cell == false then
        return {
            top = size,
            right = alt,
            bottom = size,
            left = alt,
        }
    end

    return {
        top = size .. 'cell',
        right = alt .. 'cell',
        bottom = size .. 'cell',
        left = alt .. 'cell',
    }
end

return {
    default_prog = { '/bin/zsh', '--login' },
    window_decorations = 'NONE | RESIZE',
    window_padding = eq_pad(0.1, 1, true),
    window_frame = {
        button_fg = colors.foreground,
        button_bg = colors.background,
        button_hover_fg = colors.background,
        button_hover_bg = colors.foreground,
    },
    enable_kitty_keyboard = true,
    enable_csi_u_key_encoding = false,
    allow_win32_input_mode = false,
    enable_tab_bar = true,
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = true,
    show_tab_index_in_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    default_cursor_style = 'BlinkingBlock',
    cursor_blink_rate = 250,
    cursor_blink_ease_in = 'Ease',
    cursor_blink_ease_out = 'Ease',
    cursor_thickness = '150%',
    line_height = font.options.line_height,
    font_size = font.options.size,
    font_rules = font.get_rules(false),
    colors = theme.get_scheme('Dark', true),
    inactive_pane_hsb = { saturation = 0.98, brightness = 0.9 },
    window_background_opacity = theme.get_opacity('Dark'),
    macos_window_background_blur = 75,
    keys = require('keymap'),
    disable_default_key_bindings = true,
    leader = { key = 'd', mods = 'CTRL' },
    harfbuzz_features = {
        'zero', -- Use a slashed zero '0' (instead of dotted)
        'kern', -- (default) kerning (todo check what is really is)
        'liga', -- (default) ligatures
        'clig', -- (default) contextual ligatures
    },
}
