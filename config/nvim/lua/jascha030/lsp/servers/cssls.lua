---@diagnostic disable: missing-fields
---@type lspconfig.options.cssls
return {
    settings = {
        scss = {
            lint = {
                unknownAtRules = 'ignore',
            },
        },
    },
}
