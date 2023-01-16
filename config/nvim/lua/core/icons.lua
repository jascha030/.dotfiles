local M = {}

M.icons = {
    alias = '',
    asterisk = '',
    bookmark = '',
    brush = '',
    calendar = '',
    composer = '',
    computer = '',
    database = '',
    documentation = '',
    editor = '',
    fileinfo = '',
    finder = '',
    git = '',
    git_sync = '',
    git_branch = '',
    git_merge = '',
    git_reject = '',
    ignore = '',
    init = '⏻',
    key = '',
    list = '',
    loadspeaker = '',
    mac = '',
    mute = '',
    npm = '',
    pin = '',
    rocket = '',
    scholar = '',
    telescope = ' ',
    term = '',
    wrench = '',
    lockfile = '',
    bitbucket = '',
    cmp_icons = {
        Text = '',
        Method = 'm',
        Function = '',
        Constructor = '',
        Field = '',
        Variable = '',
        Class = '',
        Interface = '',
        Module = '',
        Property = '',
        Unit = '',
        Value = '',
        Enum = '',
        Keyword = '',
        Snippet = '',
        Color = '',
        File = '',
        Reference = '',
        Folder = '',
        EnumMember = '',
        Constant = '',
        Struct = '',
        Event = '',
        Operator = '',
        TypeParameter = '',
    },
    diagnostics = {
        DiagnosticSignError = '',
        DiagnosticSignWarn = '',
        DiagnosticSignHint = '',
        DiagnosticSignInfo = '',
    },
}

function M.get_diagnostic_signs()
    local signs = {}

    for k, v in icons.diagnostics do
        table.insert(signs, { name = k, text = v})
    end

    return signs
end

return M

