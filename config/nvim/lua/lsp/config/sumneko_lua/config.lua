local M = {}

local root = os.getenv('HOME') .. '/tools/lua-language-server'
local binary = root .. '/bin/lua-language-server'

local defaults = {
    root = root,
    binary = binary,
    runtime = {
        nvim = {
            include_all = false,
            plugins = {},
        },
    },
}

M.options = {}

function M.setup(options)
    M.options = vim.tbl_deep_extend('force', {}, defaults, options or {})
end

function M.extend(options)
    M.options = vim.tbl_deep_extend('force', {}, M.options or defaults, options or {})
end

M.setup()

return M
