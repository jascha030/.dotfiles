local utils = { }

require('scopes')

function utils.set_options(scope, options)
    for key, value  in pairs(options) do
        scope[key] = value
    end
end

function utils.opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

function utils.map(mode, lhs, rhs, opts)
	local options = {noremap = true}
	if opts then
		options = vim.tbl_extend('force', options, opts) 
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return utils

