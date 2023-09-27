--- @class KeymapsUtil
local M = {
    -- maps = {},
    default_opts = {
        noremap = true,
    },
}

-- @TODO: Store in M.maps, with optional description for which-key.
function M.map(mtype, lhs, rhs, opts)
    vim.api.nvim_set_keymap(mtype, lhs, rhs, opts or M.default_opts)
end

function M.set_keymaps(options)
    for mtype, type_maps in pairs(options) do
        for lhs, args in pairs(type_maps) do
            M.map(mtype, lhs, args[1], args[2] or M.default_opts)
        end
    end
end

return M
