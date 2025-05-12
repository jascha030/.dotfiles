return require('jascha030.lsp').config.extend({
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = {
                enable = true,
            },
        },
    },
})
