---@type LazyPluginSpec
local M = {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = '<cmd>Copilot auth<cr>',
    event = { 'InsertEnter' },
    keys = {
        {
            '<leader>uC',
            function()
                if require('copilot.client').is_disabled() then
                    require('copilot.command').enable()
                else
                    require('copilot.command').disable()
                end
            end,
        },
    },
    opts = {
        enabled = true,
        panel = {
            enabled = false,
        },
        filetypes = {
            markdown = true,
        },
    },
}

function M.config(_, opts)
    local cmp = require('cmp')
    local copilot = require('copilot.suggestion')
    local luasnip = require('luasnip')

    require('copilot').setup(opts)

    ---@param trigger boolean
    local function set_trigger(trigger)
        if not trigger and copilot.is_visible() then
            copilot.dismiss()
        end

        vim.b['copilot_suggestion_auto_trigger'] = trigger
        vim.b['copilot_suggestion_hidden'] = not trigger
    end

    -- Hide suggestions when the completion menu is open.
    cmp.event:on('menu_opened', function()
        set_trigger(false)
    end)

    cmp.event:on('menu_closed', function()
        set_trigger(not luasnip.expand_or_locally_jumpable())
    end)
end

return M
