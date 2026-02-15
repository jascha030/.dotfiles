---@module 'nvim-lspconfig.configs'
---@diagnostic disable: missing-fields
---@type lspconfig.Config
return Jascha030.lsp.config_extend({
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                special = {
                    ['lreq'] = 'require',
                },
            },
            diagnostics = {
                enable = true,
                globals = {
                    'hs',
                    'spoon',
                    'vim',
                },
            },
            completion = {
                autoRequire = true,
                callSnippet = 'Disable',
                displayContext = 2,
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
        },
    },
})
