local M = {}

local default = {
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
    nmode = '',
    pin = '',
    rocket = '',
    scholar = '',
    telescope = ' ',
    term = '',
    wrench = '',
    lockfile = '',
    bitbucket = '',
    package = '',
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

M.icons = {}

function M.extend(options)
    if type(options) ~= 'table' and type(options) ~= 'nil' then
        return
    end

    M.icons = vim.tbl_deep_extend('force', {}, M.icons, options or {})
end

function M.get_icons()
    return M.icons
end

function M.get_diagnostic_signs()
    local signs = {}

    for k, v in M.icons.diagnostics do
        table.insert(signs, { name = k, text = v })
    end

    return signs
end

M.extend(default)

return M
