local wezterm = require 'wezterm';

local fonts = {
  size = 17.0,
  normal = wezterm.font('MesloLGS Nerd Font'),
  italic = wezterm.font(
    'Dank Mono',
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


--'#646ce3',
--'#526fff',
--'#a395cf',
--'#70c0b1',
--'#eaeaea',


local nitepal = {
    '#1a1423', -- Xiketic (Dark)
    colors.red,
    --'#b5bd68', -- Middle green yellow
    --'#61d33f',
    '#d4eb70',
    colors.yellow,
    '#0083f7', -- blue
    '#6f42c1', -- Plump purple
    '#8494FF',
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
    '#cdffb0',
    '#e7c547',
    '#c397d8',
    '#7fefef',
    '#a395cf', -- Blue bell
    '#fefefe'
  }
}

return {
  default_prog = {'/usr/local/bin/zsh', '--login'},
  window_decorations = 'NONE | RESIZE',
  window_padding = {
    left = 6,
    right = 6,
    top = 4,
    bottom = 0
  },
  enable_tab_bar = false,
  default_cursor_style = 'BlinkingBlock',
  cursor_blink_rate = 250,
  cursor_blink_ease_in = 'Ease',
  cursor_blink_ease_out = 'Ease',

  colors = scheme,

  font = fonts.normal,

  font_rules = {
    {
      italic = false,
      intensity = 'Normal',
      font = wezterm.font('MesloLGS Nerd Font', {
        italic = false,
        weight = 600
      })
    },
    {
      italic = true,
      intensity = 'Bold',
      font = fonts.normal
    },
    {
      italic = true,
      intensity = 'Normal',
      font = fonts.italic
    }
  },
  font_size = fonts.size,
}

