---@type Utils utils
-- local utils = require('jascha030.utils')

-- local root = os.getenv('HOME') .. '/tools/lua-language-server'
-- local binary = root .. '/bin/lua-language-server'
--
-- local M = {}
--
-- function M.paths()
--     local path = utils.fs.in_neovim() and vim.split(package.path, ';') or {}
--
--     for _, p in ipairs({ 'lua/?.lua', 'lua/?/init.lua' }) do
--         table.insert(path, p)
--     end
--
--     return path
-- end
--
-- function M.version()
--     local ret = { 'LuaJIT' }
--
--     if utils.tbl.tbl_length(ret) == 1 then
--         return 'LuaJIT'
--     end
--
--     return ret
-- end
--
-- local function globals()
--     local ret = {}
--
--     local available_globals = {
--         ['vim'] = utils.fs.in_neovim(),
--         ['hs'] = utils.fs.in_hammerspoon(),
--         ['spoon'] = utils.fs.in_hammerspoon(),
--     }
--
--     for gv, f in pairs(available_globals) do
--         -- stylua: ignore
--         if f then table.insert(ret, gv) end
--     end
--
--     return ret
-- end
--

return {
    settings = {
        Lua = {
            completion = {
                callSnippet = 'Replace',
            },
            telemetry = {
                enable = false,
            },
            workspace = {
                checkThirdParty = false,
            },
        },
    },
}
