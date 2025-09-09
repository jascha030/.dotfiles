---@type WezThemeConfig theme
local theme = require('theme')
local handlers = require('handlers')
local colors = theme.get_scheme('Dark', true)
local font = require('fonts')

font.extend({
    font_list = {
        -- { family = 'Cascadia Code', weight = 'Book' },
        'Cascadia Code',
        'nonicons',
        'CaskaydiaCove Nerd Font',
        'PragmataPro Liga',
        'PragmataPro Mono Liga',
        'Noto Color Emoji',
        'JetBrains Mono',
    },
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
        return { top = size, right = alt, bottom = size, left = alt }
    end

    return {
        top = size .. 'cell',
        right = alt .. 'cell',
        bottom = size .. 'cell',
        left = alt .. 'cell',
    }
end

local config = require('wezterm').config_builder()
config = font.extend_config(config)

for _, gpu in ipairs(require('wezterm').gui.enumerate_gpus()) do
    if gpu.backend == 'Metal' then
        config.webgpu_preferred_adapter = gpu
        config.front_end = 'WebGpu'
        break
    end
end

config.max_fps = 120


config.font_shaper = 'Harfbuzz'
config.harfbuzz_features = { 'zero', 'calt', 'liga', 'kern', 'dlig', 'ss02', 'ss03', 'ss05', 'ss09' }
config.freetype_load_target = 'Normal'
config.freetype_render_target = 'Light'
config.freetype_load_flags = 'NO_HINTING|FORCE_AUTOHINT'
config.allow_win32_input_mode = false
config.audible_bell = 'Disabled'
config.colors = theme.get_scheme('Dark', true)
config.cursor_blink_ease_in = 'Ease'
config.cursor_blink_ease_out = 'Ease'
config.cursor_blink_rate = 250
config.cursor_thickness = '150%'
config.default_cursor_style = 'BlinkingBlock'
config.default_prog = { '/bin/zsh', '--login' }
config.disable_default_key_bindings = true
config.enable_tab_bar = true
config.unicode_version = 14
config.warn_about_missing_glyphs = false -- This will help identify missing characters
config.hide_tab_bar_if_only_one_tab = true
config.inactive_pane_hsb = { saturation = 0.98, brightness = 0.9 }
config.keys = require('keymap')
config.leader = { key = 'd', mods = 'CTRL' }
config.term = 'xterm-256color'
config.macos_window_background_blur = 75
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false
config.show_tab_index_in_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_background_opacity = theme.get_opacity('Dark')
config.window_decorations = 'NONE | RESIZE'
config.window_frame = {
    button_fg = colors.foreground,
    button_bg = colors.background,
    button_hover_fg = colors.background,
    button_hover_bg = colors.foreground,
}
config.window_padding = eq_pad(0.1, 1, true)
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
