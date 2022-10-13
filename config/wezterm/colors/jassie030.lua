local wezterm = require('wezterm')
local colorscheme = dofile(wezterm.home_dir .. '/.dotfiles/config/lua/colorschemes/jassie030.lua')

return colorscheme.get_scheme()
