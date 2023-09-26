local M = { default_opts = { noremap = true } }

local map = vim.api.nvim_set_keymap

function M.map(mtype, lhs, rhs, opts)
	map(mtype, lhs, rhs, opts or M.default_opts)
end

function M.set_keymaps(options)
	for mtype, type_maps in pairs(options) do
		for lhs, args in pairs(type_maps) do
			M.map(mtype, lhs, args[1], args[2] or M.default_opts)
		end
	end
end

return M
