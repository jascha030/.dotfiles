local scopes = {
	g = vim.g,
	o = vim.o,
	b = vim.bo,
	bo = vim.bo,
	w = vim.wo,
	wo = vim.wo,
}

return function(key, val, scope)
	if not scope then
		vim.opt[key] = val
	else
		scopes[scope][option_key] = val
	end
end
