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
--[[==========================Configuration===========================]]


require('options')
require('plugins')
require('lsp')
require('keymap')

ActiveUserColorscheme = require('scheme').setup({
    overrides = {
        dark = {
            bg_dark = 'background',
        },
        light = {
            blue = 'blue',
            yellow = 'red',
            purple = 'bright_red',
            green1 = 'cyan',
            green = 'green',
        },
    },
})

local kmap = require('util').kmap

kmap('CS', ':lua ActiveUserColorscheme:toggle()<CR>', 'n', { noremap = true })
