---@diagnostic disable: missing-fields
---@type vim.lsp.ClientConfig
local bashls = {
    filetypes = {
        'bash',
        'sh',
        'zsh',
    },
    single_file_support = true,
}

return require('jascha030.lsp').config.extend(bashls)
