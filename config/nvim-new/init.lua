-- stylua: ignore-start
--[[========================== Jascha030's =============================--
--   __  __  __  __  ______                __       __  __  ______      --
--  /\ \/\ \/\ \/\ \/\__  _\   /'\_/`\    /\ \     /\ \/\ \/\  _  \     --
--  \ \ `\\ \ \ \ \ \/_/\ \/  /\      \   \ \ \    \ \ \ \ \ \ \L\ \    --
--   \ \ , ` \ \ \ \ \ \ \ \  \ \ \__\ \   \ \ \  __\ \ \ \ \ \  __ \   --
--    \ \ \`\ \ \ \_/ \ \_\ \__\ \ \_/\ \   \ \ \L\ \\ \ \_\ \ \ \/\ \  --
--     \ \_\ \_\ `\___/ /\_____\\ \_\\ \_\   \ \____/ \ \_____\ \_\ \_\ --
--      \/_/\/_/`\/__/  \/_____/ \/_/ \/_/    \/___/   \/_____/\/_/\/_/ --
--[[================ beep-beep-Config-2.0-beep-boop ====================]]
-- stylua: ignore-end

vim.loader.enable()
vim.g.maploader = ' '

local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local conf_path = vim.fn.stdpath('config') --[[@as string]]

if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--single-branch',
        'https://github.com/folke/lazy.nvim.git',
        lazy_path,
    })
end

vim.opt.runtimepath:prepend(lazy_path)

require('lazy').setup({
    { import = 'jascha030.plugins' },
    {
        name = 'jascha030.init',
        main = 'jascha030',
        dir = conf_path,
        lazy = false,
        config = function()
            require('jascha030')
        end,
    },
}, {
    concurrency = 5,
    performance = {
        browser = 'arc',
        cache = {
            enabled = true,
            disable_events = { 'UiEnter' },
        },
        ui = {
            border = vim.g.global_border_style,
        },
        reset_packpath = true,
        rtp = {
            reset = true,
            disabled_plugins = {
                'gzip',
                'matchit',
                'matchparen',
                'netrwPlugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
                'man',
                'osc52', -- Wezterm doesn't support osc52 yet
                'spellfile',
            },
        },
    },
    ui = { border = BORDER },
})

