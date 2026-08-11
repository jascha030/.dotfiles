---@diagnostic disable: missing-fields
return {
    filetypes = { 'bash', 'sh' },
    settings = {
        bashIde = {
            shfmt = { enable = false }, -- let conform handle formatting
            shellcheck = { enable = true },
        },
    },
}
