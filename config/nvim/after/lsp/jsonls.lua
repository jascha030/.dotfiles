---@diagnostic disable: missing-fields
return {
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = {
                enable = true,
            },
        },
    },
}
