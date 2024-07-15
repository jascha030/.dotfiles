--- @class KeymapsUtil
local M = {
    default_opts = { noremap = true },
}

-- @TODO: Store in M.maps, with optional description for which-key.
function M.map(mode, lhs, rhs, opts)
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts or M.default_opts)
end

function M.set_keymaps(options)
    for mode, type_maps in pairs(options) do
        for _, args in pairs(type_maps) do
            M.map(mode, args[1], args[2], args.opts or M.default_opts)
        end
    end
end

return M
