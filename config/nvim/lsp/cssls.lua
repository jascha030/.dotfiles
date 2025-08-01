---@diagnostic disable: missing-fields
return Jascha030.lsp.config_extend({
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    root_markers = { 'package.json', '.git' },
    init_options = { provideFormatter = false },
    settings = {
        css = { validate = true },
        less = { validate = true },
        scss = {
            validate = false,
            lint = {
                unknownAtRules = 'ignore',
            },
        },
    },
})
