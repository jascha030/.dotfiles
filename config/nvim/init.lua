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

local kmap = require('util').kmap

require('scheme').setup({
    overrides = {
        dark = {
            bg_dark = 'background',
            green = 'green',
            red = 'red',
            yellow = 'yellow',
        },
        light = {
            bg = 'background',
            bg_dark = 'background',
            blue = 'cyan',
            yellow = 'red',
            purple = 'bright_red',
            green1 = 'cyan',
            teal = 'red',
            green = 'green',
        },
    },
})

kmap('CS', '<cmd>lua require("scheme").toggle()<CR>', 'n', { noremap = true })

require('options')
require('plugins')
require('lsp')
require('keymap')

