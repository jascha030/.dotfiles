---@module 'nvim-lspconfig.configs'
---@diagnostic disable: missing-fields
---@type lspconfig.Config
return Jascha030.lsp.config_extend({
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
})
