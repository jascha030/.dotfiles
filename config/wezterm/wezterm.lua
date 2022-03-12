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
  background_dark = '#1a1423', -- Xiketic (Dark)

  foreground = "#a6accd",

  yellow = '#ffcc00',
  red = '#ea1479'
}

-- ANSI
-- black
-- red
-- green
-- yellow
-- blue
-- magenta
-- cyan
-- white

local ansi_one = {
    '#1d1f21', -- Eerie black
    '#ea1479', -- Red purple/razzmatazz
    '#b5bd68', -- Middle green yellow
    '#ffcc00', -- Sunglow
    '#81a2be', -- Green
    '#b294bb', -- Glossy grape
    '#a395cf', -- Blue bell
    '#c5c8c6'  -- Silver sand
}

local nitepal = {
    '#1a1423', -- Xiketic (Dark)
    colors.red,
    --'#b5bd68', -- Middle green yellow
    '#61d33f',
    colors.yellow,
    '#0083f7', -- blue
    --'#526fff', -- Neon blue
    '#6f42c1', -- Plump purple
    '#a395cf', -- Blue bell
    '#c5c8c6'  -- Languid lavendaer
}

local scheme = {
  background = colors.background,
  foreground = colors.foreground,
  cursor_bg = colors.yellow,
  cursor_fg = colors.background,

  ansi = nitepal,

  brights = {
    '#666666',
    '#F47CB4',
    -- '#FF4454',
    -- '#F0569E',
    -- '#d54e53',
    -- '#b9ca4a',
    '#9deb6f',
    '#e7c547',
    '#7aa6da',
    '#c397d8',
    -- '#000000',
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

  cursor_blink_rate = 250,
  cursor_blink_ease_in = "Ease",
  cursor_blink_ease_out = "Ease",

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

