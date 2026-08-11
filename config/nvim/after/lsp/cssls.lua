---@diagnostic disable: missing-fields
return {
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    root_markers = { 'package.json', '.git' },
    init_options = { provideFormatter = false },
    settings = {
        css = {
            validate = true,
            lint = {
                unknownAtRules = 'ignore',
                unusedSelectors = 'warning',
            },
        },
        less = {
            validate = true,
            lint = {
                unknownAtRules = 'ignore',
                unusedSelectors = 'warning',
            },
        },
        scss = {
            validate = true,
            lint = {
                unknownAtRules = 'ignore',
                unusedSelectors = 'warning',
            },
        },
    },
}
