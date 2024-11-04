---@diagnostic disable: missing-fields
return function()
    local utils = require('jascha030.utils')

    local function globals()
        local ret = {}

        local available_globals = {
            ['vim'] = utils.fs.in_neovim(),
            ['hs'] = utils.fs.in_hammerspoon(),
        }

        for gv, f in pairs(available_globals) do
            if f then
                table.insert(ret, gv)
            end
        end

        return ret
    end

    ---@type lspconfig.options.lua_ls
    local lua_ls = {
        settings = {
            Lua = {
                completion = {
                    callSnippet = 'Replace',
                },
                -- workspace = {
                --     checkThirdParty = true,
                -- },
                -- hint = {
                --     enable = true,
                --     setType = true,
                --     arrayIndex = 'Disable',
                -- },
                -- format = {
                --     enable = false,
                -- },
                -- telemetry = {
                --     enable = false,
                -- },
                -- diagnostics = {
                --     globals = globals(),
                -- },
                -- runtime = {
                --     special = {
                --         ['lreq'] = 'require',
                --     },
                -- },
            },
        },
    }

    return lua_ls
end
