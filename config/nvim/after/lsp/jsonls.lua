---@diagnostic disable: missing-fields
return Jascha030.lsp.config_extend({
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = {
                enable = true,
            },
        },
    },
})
