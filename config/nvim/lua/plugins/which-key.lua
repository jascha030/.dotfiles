---@type LazyPluginSpec
local M = {
    'folke/which-key.nvim',
    event = { 'VeryLazy' },
    keys = {
        {
            '<leader>?',
            function()
                require('which-key').show({ global = false })
            end,
            desc = 'Buffer Local Keymaps (which-key)',
        },
    },
}

function M.opts()
    local keymaps = require('jascha030.core.config').options.keymaps
    local results = {}

    for mode, tmaps in pairs(keymaps) do ---@diagnostic disable-line: param-type-mismatch
        for _, args in pairs(tmaps) do
            local opts = args.opts or {}
            local map = { args[1], args[2], desc = args.desc or args[2], mode = mode }

            for _, v in pairs({
                'noremap',
                'remap',
                'silent',
                'group',
                'desc',
                'icon',
                'buffer',
                'mode',
                'cond',
            }) do
                if args[v] ~= nil then
                    map[v] = args[v]
                end

                if opts[v] ~= nil then
                    map[v] = opts[v]
                end
            end

            table.insert(results, map)
        end
    end

    return { spec = results }
end

return M
