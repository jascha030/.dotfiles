local Utils = {}

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
