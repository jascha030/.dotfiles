local Utils = {}

Utils.data_path = function(subpath)
    local args = { vim.fn.stdpath("data") }

    if subpath ~= nil then
	table.insert(args, subpath)
    end
    
    return string.format(subpath ~= nil and "%s/site" or "%s/site/%s", table.unpack(args))
end

Utils.wrap = function(fnc, ...)
	local params = { ... }

	if type(fnc) ~= "function" then
		local prev = fnc

		fnc = function(...)
			return prev
		end
	end

	return function()
		return fnc(unpack(params))
	end
end

return setmetatable(Utils, {
	__index = function(self, key)
		local ok, submod = pcall(require, "utils." .. key)

		return ok and submod or nil
	end,
})
