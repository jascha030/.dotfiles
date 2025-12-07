-- https://github.com/davidosomething/dotfiles/blob/04cccb6d81a0d9f7a50a7a59834c1c6f7393272d/nvim/lua/dko/utils/buffer.lua
local M = {}
local HIGHLIGHTING_MAX_FILESIZE = 300 * 1024 -- 300 KB

---@param query string|table can be a filename or a { bufnr }
---@return boolean|nil true if filesize is bigger than HIGHLIGHTING_MAX_FILESIZE
M.is_huge = function(query)
    local filename = query
    if type(query) == 'table' and query.bufnr then
        filename = vim.api.nvim_buf_get_name(query.bufnr)
    end
    local ok, stats = pcall(vim.uv.fs_stat, filename)
    return ok and stats and stats.size > HIGHLIGHTING_MAX_FILESIZE
end

return M
