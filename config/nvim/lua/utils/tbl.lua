local M = {}

local function value_index(table)
	local set = {}
	for _, v in ipairs(table) do
		set[v] = true
	end

	return set
end

local function count(table)
	local _count = 0
	for _, _ in ipairs(table) do
		_count = _count + 1
	end

	return _count
end

function M.tbl_contains(t, v)
	local map = value_index(t)

	return map[v] or false
end

function M.tbl_length(t)
	assert(t == nil or type(t) == "table", "bad parameter #1: must be of type table or nil.")
	if t == nil then
		return 0
	end

	return count(t)
end

function M.tbl_merge(t1, t2)
	for _, v in ipairs(t2) do
		table.insert(t1, v)
	end

	return t1
end

return M
