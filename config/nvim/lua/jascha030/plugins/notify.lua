local theme = lreq('jascha030.utils.theme')

---@type LazyPluginSpec
local M = {
    'rcarriga/nvim-notify',
    cond = false,
    keys = {
        {
            '<leader>un',
            function()
                require('notify').dismiss({ silent = true, pending = true })
            end,
            desc = 'Delete all Notifications',
        },
    },
    opts = {
        background_colour = theme.get_background(),
        timeout = 2000,
        stages = 'static',
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.75)
        end,
    },
}

return M
