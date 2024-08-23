---@type WezThemeConfig theme
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

local config = require('wezterm').config_builder()

config.default_prog = { '/bin/zsh', '--login' }
config.window_decorations = 'NONE | RESIZE'
config.window_padding = eq_pad(0.1, 1, true)
config.window_frame = {
    button_fg = colors.foreground,
    button_bg = colors.background,
    button_hover_fg = colors.background,
    button_hover_bg = colors.foreground,
}
config.allow_win32_input_mode = false
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_tab_index_in_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 250
config.cursor_blink_ease_in = 'Ease'
config.cursor_blink_ease_out = 'Ease'
config.cursor_thickness = '150%'
config.line_height = font.options.line_height
config.font_size = font.options.size
config.font_rules = font.get_rules(false)
config.colors = theme.get_scheme('Dark', true)
config.inactive_pane_hsb = { saturation = 0.98, brightness = 0.9 }
config.window_background_opacity = theme.get_opacity('Dark')
config.macos_window_background_blur = 75
config.keys = require('keymap')
config.disable_default_key_bindings = true
config.leader = { key = 'd', mods = 'CTRL' }
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false
config.harfbuzz_features = {
    'zero', -- Use a slashed zero '0' (instead of dotted)
    'kern', -- (default) kerning (todo check what is really is)
    'liga', -- (default) ligatures
    'clig', -- (default) contextual ligatures
}
config.hyperlink_rules = {
    -- Linkify things that look like URLs and the host has a TLD name.
    { regex = '\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b', format = '$0' },
    -- linkify email addresses
    { regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]], format = 'mailto:$0' },
    -- file:// URI
    { regex = [[\bfile://\S*\b]], format = '$0' },
    -- Linkify things that look like URLs with numeric addresses as hosts.
    -- E.g. http://127.0.0.1:8000 for a local development server,
    -- or http://192.168.1.1 for the web interface of many routers.
    { regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]], format = '$0' },
    -- Make username/project paths clickable. This implies paths like the following are for GitHub.
    -- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
    -- As long as a full URL hyperlink regex exists above this it should not match a full URL to
    -- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
    { regex = [["([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)"]], format = 'https://www.github.com/$1/$3' },
}

return config
