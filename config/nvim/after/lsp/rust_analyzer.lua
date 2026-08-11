---@diagnostic disable: missing-fields
return {
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
            checkOnSave = true,
        },
    },
}
