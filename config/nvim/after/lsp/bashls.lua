---@diagnostic disable: missing-fields
return Jascha030.lsp.config_extend({
    filetypes = { 'bash', 'sh', 'zsh', },
    settings = {
        bashIde = {
            shfmt = { enable = false }, -- let conform handle formatting
            shellcheck = { enable = true },
        },
    },
})
