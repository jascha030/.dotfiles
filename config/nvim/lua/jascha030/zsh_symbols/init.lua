local uv = vim.uv

local M = {}

local SYMBOL_KIND = vim.lsp.protocol.SymbolKind.Function
local SYMBOL_CHARS = '[%w_:%-]'

local function normalize(path)
    if path == nil or path == '' then
        return nil
    end

    local expanded = vim.fn.fnamemodify(path, ':p')
    local realpath = uv.fs_realpath(expanded)

    return vim.fs.normalize(realpath or expanded)
end

local function path_join(...)
    return normalize(vim.fs.joinpath(...))
end

local DOTFILES_ROOT = normalize(vim.env.DOTFILES or vim.fn.expand('~/.dotfiles'))
local ZSH_ROOT = path_join(DOTFILES_ROOT, 'config', 'zsh')
local AUTOLOAD_DIRS = {
    path_join(ZSH_ROOT, 'zfunc'),
    path_join(ZSH_ROOT, 'prompt', 'functions'),
}
local cached_index = nil

local function is_under(path, root)
    local normalized_path = normalize(path)
    local normalized_root = normalize(root)

    if normalized_path == nil or normalized_root == nil then
        return false
    end

    return normalized_path == normalized_root or normalized_path:find(normalized_root .. '/', 1, true) == 1
end

local function is_scannable_file(path)
    local normalized_path = normalize(path)

    if normalized_path == nil or not is_under(normalized_path, ZSH_ROOT) then
        return false
    end

    if normalized_path:match('%.zwc$') or normalized_path:match('%.md$') or normalized_path:match('/%.DS_Store$') then
        return false
    end

    return true
end

local function read_lines(path)
    local ok, lines = pcall(vim.fn.readfile, path)

    if ok then
        return lines
    end

    return {}
end

local function list_files(root, acc)
    for name, entry_type in vim.fs.dir(root) do
        local path = vim.fs.joinpath(root, name)

        if entry_type == 'directory' then
            list_files(path, acc)
        elseif entry_type == 'file' and is_scannable_file(path) then
            acc[#acc + 1] = normalize(path)
        end
    end
end

local function make_symbol(name, kind, path, line, character)
    return {
        name = name,
        kind = kind,
        path = path,
        line = line,
        character = character,
        container_name = vim.fs.basename(path),
    }
end

local function symbol_name_at(line, character)
    if line == nil or line == '' then
        return nil
    end

    local index = character + 1
    local length = #line

    if index < 1 then
        index = 1
    elseif index > length then
        index = length
    end

    if length == 0 then
        return nil
    end

    local current = line:sub(index, index)
    if current:match(SYMBOL_CHARS) == nil and index > 1 then
        index = index - 1
        current = line:sub(index, index)
    end

    if current:match(SYMBOL_CHARS) == nil then
        return nil
    end

    local start_col = index
    local end_col = index

    while start_col > 1 and line:sub(start_col - 1, start_col - 1):match(SYMBOL_CHARS) do
        start_col = start_col - 1
    end

    while end_col < length and line:sub(end_col + 1, end_col + 1):match(SYMBOL_CHARS) do
        end_col = end_col + 1
    end

    return line:sub(start_col, end_col)
end

local function explicit_symbols(path, lines)
    local symbols = {}

    for line_number, line in ipairs(lines) do
        local name = line:match('^%s*function%s+([%w_:%-]+)%s*%(%s*%)%s*{')
            or line:match('^%s*function%s+([%w_:%-]+)%s*{')
            or line:match('^%s*([%w_:%-]+)%s*%(%s*%)%s*{')

        if name ~= nil then
            local start_col = (line:find(name, 1, true) or 1) - 1
            symbols[#symbols + 1] = make_symbol(name, 'explicit', path, line_number, start_col)
        end
    end

    return symbols
end

local function first_meaningful_line(lines)
    for line_number, line in ipairs(lines) do
        if not (line_number == 1 and line:match('^#!')) and not (line:match('^%s*$') or line:match('^%s*#')) then
            return line_number, 0
        end
    end

    return 1, 0
end

local function trailing_invocation_line(lines, symbols)
    local explicit_names = {}

    for _, symbol in ipairs(symbols) do
        explicit_names[symbol.name] = true
    end

    for line_number = #lines, 1, -1 do
        local line = lines[line_number]

        if not (line_number == 1 and line:match('^#!')) and not (line:match('^%s*$') or line:match('^%s*#')) then
            local name = line:match('^%s*([%w_:%-]+)%f[^%w_:%-]')

            if name ~= nil and explicit_names[name] then
                return line_number, (line:find(name, 1, true) or 1) - 1
            end
        end
    end

    return nil, nil
end

local function autoload_name(path)
    local basename = vim.fs.basename(path)

    if basename:find('%.', 1, true) ~= nil then
        return nil
    end

    for _, dir in ipairs(AUTOLOAD_DIRS) do
        if is_under(path, dir) then
            return basename
        end
    end

    return nil
end

local function file_symbols(path, lines)
    local symbols = explicit_symbols(path, lines)
    local autoload = autoload_name(path)

    if autoload == nil then
        return symbols
    end

    for _, symbol in ipairs(symbols) do
        if symbol.name == autoload then
            return symbols
        end
    end

    local line_number, character = trailing_invocation_line(lines, symbols)

    if line_number == nil then
        line_number, character = first_meaningful_line(lines)
    end

    symbols[#symbols + 1] = make_symbol(autoload, 'autoload', path, line_number, character)

    return symbols
end

local function add_symbol(index, symbol)
    index.all[#index.all + 1] = symbol
    index.by_file[symbol.path] = index.by_file[symbol.path] or {}
    index.by_name[symbol.name] = index.by_name[symbol.name] or {}

    index.by_file[symbol.path][#index.by_file[symbol.path] + 1] = symbol
    index.by_name[symbol.name][#index.by_name[symbol.name] + 1] = symbol
end

local function symbol_sort(a, b)
    if a.name ~= b.name then
        return a.name < b.name
    end

    if a.kind ~= b.kind then
        return a.kind < b.kind
    end

    if a.path ~= b.path then
        return a.path < b.path
    end

    return a.line < b.line
end

local function location_sort(a, b)
    if a.kind ~= b.kind then
        return a.kind == 'explicit'
    end

    if a.path ~= b.path then
        return a.path < b.path
    end

    return a.line < b.line
end

local function build_index()
    local files = {}
    local index = {
        all = {},
        by_name = {},
        by_file = {},
    }

    list_files(ZSH_ROOT, files)
    table.sort(files)

    for _, path in ipairs(files) do
        local symbols = file_symbols(path, read_lines(path))

        for _, symbol in ipairs(symbols) do
            add_symbol(index, symbol)
        end
    end

    for _, symbols in pairs(index.by_name) do
        table.sort(symbols, location_sort)
    end

    for _, symbols in pairs(index.by_file) do
        table.sort(symbols, function(a, b)
            if a.line ~= b.line then
                return a.line < b.line
            end

            return a.name < b.name
        end)
    end

    table.sort(index.all, symbol_sort)

    return index
end

local function get_index()
    if cached_index == nil then
        cached_index = build_index()
    end

    return cached_index
end

local function location(symbol)
    return {
        uri = vim.uri_from_fname(symbol.path),
        range = {
            start = { line = symbol.line - 1, character = symbol.character },
            ['end'] = { line = symbol.line - 1, character = symbol.character + #symbol.name },
        },
    }
end

local function symbol_information(symbol)
    return {
        name = symbol.name,
        kind = SYMBOL_KIND,
        location = location(symbol),
        containerName = symbol.container_name,
    }
end

local function current_lines(path)
    local bufnr = vim.fn.bufnr(path)

    if bufnr > 0 and vim.api.nvim_buf_is_loaded(bufnr) then
        return vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    end

    return read_lines(path)
end

function M.root()
    return DOTFILES_ROOT
end

function M.zsh_root()
    return ZSH_ROOT
end

function M.is_repo_zsh_path(path)
    return is_under(path, ZSH_ROOT)
end

function M.definition(params)
    local path = normalize(vim.uri_to_fname(params.textDocument.uri))

    if path == nil or not M.is_repo_zsh_path(path) then
        return {}
    end

    local line = current_lines(path)[params.position.line + 1]
    local name = symbol_name_at(line, params.position.character)

    if name == nil then
        return {}
    end

    local matches = get_index().by_name[name] or {}
    local locations = {}

    for _, symbol in ipairs(matches) do
        locations[#locations + 1] = location(symbol)
    end

    return locations
end

function M.document_symbols(uri)
    local path = normalize(vim.uri_to_fname(uri))

    if path == nil or not M.is_repo_zsh_path(path) then
        return {}
    end

    local symbols = file_symbols(path, current_lines(path))
    local result = {}

    for _, symbol in ipairs(symbols) do
        result[#result + 1] = symbol_information(symbol)
    end

    return result
end

function M.workspace_symbols(query)
    local lowered = query:lower()
    local result = {}

    for _, symbol in ipairs(get_index().all) do
        if lowered == '' or symbol.name:lower():find(lowered, 1, true) ~= nil then
            result[#result + 1] = symbol_information(symbol)
        end
    end

    return result
end

function M.invalidate()
    cached_index = nil
end

return M
