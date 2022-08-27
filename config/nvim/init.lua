--[[===========================Jascha030's==============================--
--                                                                      --
--   __  __  __  __  ______                __       __  __  ______      --
--  /\ \/\ \/\ \/\ \/\__  _\   /'\_/`\    /\ \     /\ \/\ \/\  _  \     --
--  \ \ `\\ \ \ \ \ \/_/\ \/  /\      \   \ \ \    \ \ \ \ \ \ \L\ \    --
--   \ \ , ` \ \ \ \ \ \ \ \  \ \ \__\ \   \ \ \  __\ \ \ \ \ \  __ \   --
--    \ \ \`\ \ \ \_/ \ \_\ \__\ \ \_/\ \   \ \ \L\ \\ \ \_\ \ \ \/\ \  --
--     \ \_\ \_\ `\___/ /\_____\\ \_\\ \_\   \ \____/ \ \_____\ \_\ \_\ --
--      \/_/\/_/`\/__/  \/_____/ \/_/ \/_/    \/___/   \/_____/\/_/\/_/ --
--                                                                      --
--                                                                      --
--[[=================beep-beep-Config-2.0-beep-boop=====================]]

vim.o.runtimepath = vim.o.runtimepath .. ',' .. os.getenv('XDG_CONFIG_HOME')

local utils = require('utils')

vim.g.mapleader = [[ ]]

local options = {
    mouse = 'nvi',
    termguicolors = true,
    incsearch = true,
    colorcolumn = '120',
    backspace = 'indent,eol,start',
    fileencoding = 'utf-8',
    fillchars = 'eob: ,msgsep:‾',
    scrolloff = 5,
    showtabline = 2,
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    smartindent = true,
    number = true,
    cursorline = true,
    modifiable = true,
    updatetime = 400,
    signcolumn = 'yes',
}

for k, v in pairs(options) do
	utils.opt(k, v)
end

