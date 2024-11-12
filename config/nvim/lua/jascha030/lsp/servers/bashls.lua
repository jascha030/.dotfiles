---@diagnostic disable: missing-fields
---@type lspconfig.options.bashls
local bashls = {
    filetypes = {
        'bash',
        'sh',
        'zsh',
    },
    single_file_support = true,
}

return bashls
