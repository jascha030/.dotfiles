local M = {}

-- local cmp_icons = {
--     Text = '',
--     Method = 'm',
--     Function = '',
--     Constructor = '',
--     Field = '',
--     Variable = '',
--     Class = '',
--     Interface = '',
--     Module = '',
--     Property = '',
--     Unit = '',
--     Value = '',
--     Enum = '',
--     Keyword = '',
--     Snippet = '',
--     Color = '',
--     File = '',
--     Reference = '',
--     Folder = '',
--     EnumMember = '',
--     Constant = '',
--     Struct = '',
--     Event = '',
--     Operator = '',
--     TypeParameter = '',
-- }

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
    picker = ' ',
    term = '',
    wrench = '',
    lockfile = '',
    bitbucket = '',
    package = '',
    cmp_icons = {
        Class = '',
        Color = '',
        Constant = '󰏿',
        Constructor = '󰒓',
        Copilot = '',
        Enum = '󰦨',
        EnumMember = '󰦨',
        Event = '',
        Field = '',
        File = '󰈔',
        Folder = '',
        Function = '󰊕',
        Interface = '󱡠',
        Keyword = '',
        Method = 'm',
        Module = '󰅩',
        Operator = '󰪚',
        Property = '󰜢',
        Reference = '',
        Snippet = '',
        Struct = '󱡠',
        Text = '󰉿',
        TypeParameter = '',
        Unit = '',
        Value = '󰦨',
        Variable = '󰆦',
    },
    diagnostics = {
        [vim.diagnostic.severity.ERROR] = '',
        [vim.diagnostic.severity.WARN] = '',
        [vim.diagnostic.severity.HINT] = '',
        [vim.diagnostic.severity.INFO] = '',
    },
}

M.icons = {}

---@param options table?
function M.extend(options)
    if type(options) ~= 'table' and type(options) ~= 'nil' then
        return
    end

    M.icons = vim.tbl_deep_extend('force', {}, M.icons, options or {})
end

function M.get_icons()
    if vim.tbl_isempty(M.icons) then
        M.extend({})
    end

    return M.icons
end

---@class DiagnosticSignIcon
---@field name string
---@field text string
---@return DiagnosticSignIcon[]
function M.get_diagnostic_signs()
    local signs = {}

    for name, text in pairs(M.get_icons().diagnostics) do
        local hl = 'DiagnosticSign' .. name

        table.insert(signs, { name = hl, text = text })
    end

    return signs
end

M.extend(default)

return M
