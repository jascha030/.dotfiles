---@type vim.lsp.Config
return {
    ---@type lspconfig.settings.lua_ls
    settings = {
        Lua = {
            completion = {
                autoRequire = true,
                callSnippet = 'Disable',
                displayContext = 2,
            },
            diagnostics = {
                enable = true,
                globals = {
                    'hs',
                    'spoon',
                    'vim',
                },
            },
            doc = {
                privateName = { '^_' },
            },
            hint = {
                enable = true,
                setType = true,
                arrayIndex = 'Disable',
                await = true,
                paramName = 'All',
                paramType = true,
                semicolon = 'SameLine',
            },
            runtime = {
                version = 'LuaJIT',
                special = {
                    ['lreq'] = 'require',
                },
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
