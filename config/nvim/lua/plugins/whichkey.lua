return {
    'folke/which-key.nvim',
    config = function()
        local keymaps = require('utils.conf').keymaps
        local wk = require('which-key')

        for mtype, tmaps in pairs(keymaps) do
            local results = {}

            for kmap, args in pairs(tmaps) do
                results[kmap] = { args[1], args[1] }
            end

            wk.register(results, { nowait = true, mode = mtype })
        end
    end,
}
