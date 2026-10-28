---@type vim.lsp.Config
return {
    cmd = { 'fennel-language-server' },
    filetypes = { 'fennel' },
    root_markers = { '.git' },
    ---@type table<string, any>
    settings = {
        fennel = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
}
