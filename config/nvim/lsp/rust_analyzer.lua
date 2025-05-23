return require('jascha030.lsp').config.extend({
    settings = {
        ['rust-analyzer'] = {
            assist = {
                importGranularity = 'module',
                importPrefix = 'by_self',
            },
            cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
            },
            procMacro = {
                enable = true,
            },
            checkOnSave = {
                command = 'clippy',
            },
        },
    },
})
