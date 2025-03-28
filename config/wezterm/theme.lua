---@class WezThemeConfig
local M = {}

local default = require('colors.jassie030').get_scheme()
local color_scheme = nil

local function is_dark(scheme)
    return scheme == 'Dark'
end

function M.scheme_from_colors(colors, tab_bar)
    local scheme = {
        background = colors.background,
        foreground = colors.foreground,
        cursor_bg = colors.bright_yellow,
        cursor_fg = colors.background,
        ansi = {
            colors.black,
            colors.red,
            colors.green,
            colors.yellow,
            colors.blue,
            colors.magenta,
            colors.cyan,
            colors.white,
        },
        brights = {
            colors.bright_black,
            colors.bright_red,
            colors.bright_green,
            colors.bright_yellow,
            colors.bright_blue,
            colors.bright_magenta,
            colors.bright_cyan,
            colors.bright_white,
        },
        split = colors.foreground,
    }

    if tab_bar ~= false then
        scheme.tab_bar = {
            background = colors.background,
            active_tab = {
                bg_color = colors.foreground,
                fg_color = colors.background,
            },
            new_tab = {
                bg_color = colors.background,
                fg_color = colors.foreground,
            },
            new_tab_hover = {
                fg_color = colors.red,
                bg_color = colors.background,
            },
        }
    end

    return scheme
end

function M.scheme_from_module(module, color_overrides)
    color_overrides = color_overrides or nil

    local ok, scheme_colors = pcall(require, module)
    if not ok then
        return
    end

    if color_overrides ~= nil then
        for k, v in pairs(color_overrides) do
            scheme_colors[k] = v
        end
    end

    return M.scheme_from_colors(scheme_colors)
end

function M.get_scheme(scheme, enable_tab_bar)
    if color_scheme == nil then
        color_scheme = default
    end

    return M.scheme_from_colors(is_dark(scheme) and color_scheme.dark or color_scheme.light, enable_tab_bar)
end

function M.get_opacity(scheme)
    return is_dark(scheme) and 0.95 or 1
end

function M.setup(config)
    config = config or {}

    if config.scheme == nil then
        color_scheme = M.scheme_from_module(config.scheme, config.overrides or nil)
    end
end

return M
