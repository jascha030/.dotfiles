local wezterm = require 'wezterm';

local fonts = {
  size = 17.0,
  normal = wezterm.font("MesloLGS Nerd Font"),
  italic = wezterm.font(
    "Dank Mono",
    {
      italic = true,
      weight = 500
    }
  )
}

local colors = {
  background = "#212431",
  foreground = "#a6accd",

  yellow = '#ffcc00',
  red = '#ea1479'
}

local scheme = {
  background = colors.background,
  foreground = colors.foreground,
  cursor_bg = colors.yellow,
  cursor_fg = colors.background,

  ansi = {
    '#1d1f21',
    '#ea1479',
    '#b5bd68',
    --'#b5bd68',
    '#ffcc00',
    '#81a2be', -- green
    '#b294bb',
    -- '#8abeb7',
    '#a395cf',
    '#c5c8c6'
  },

  brights = {
    '#666666',
    '#F47CB4',
    -- '#FF4454',
    -- '#F0569E',
    --'#d54e53',
    --'#b9ca4a',
    '#9deb6f',
    '#e7c547',
    '#7aa6da',
    '#c397d8',
    '#70c0b1',
    '#eaeaea'
  }
}

return {
  default_prog = {"/usr/local/bin/zsh", "--login"},

  window_decorations = "NONE | RESIZE",
  window_padding = {
    left = 6,
    right = 6,
    top = 4,
    bottom = 0
  },
  enable_tab_bar = false,

  --initial_rows = 45,
  --initial_cols = 175,
  default_cursor_style = "BlinkingBlock",

  colors = scheme,

  font = fonts.normal,
  font_rules = {
    {
      italic = false,
      intensity = "Normal",
      font = wezterm.font("MesloLGS Nerd Font", {
        italic = false,
        weight = 600
      })
    },
    {
      italic = true,
      intensity = "Bold",
      font = fonts.normal
    },
    {
      italic = true,
      intensity = "Normal",
      font = fonts.italic
    }
  },
  font_size = fonts.size,
}

