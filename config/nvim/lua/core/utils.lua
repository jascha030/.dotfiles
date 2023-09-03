local M = {}

M.root_patterns = { '.git', 'lua' }

function M.get_root()
    ---@type string?
    local path = vim.api.nvim_buf_get_name(0)

    path = path ~= '' and vim.loop.fs_realpath(path) or nil
    ---@type string[]
    local roots = {}

    if path then
        for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            local workspace = client.config.workspace_folders
            local paths = workspace
                    and vim.tbl_map(function(ws)
                        return vim.uri_to_fname(ws.uri)
                    end, workspace)
                or client.config.root_dir and { client.config.root_dir }
                or {}
            for _, p in ipairs(paths) do
                local r = vim.loop.fs_realpath(p)
                if path:find(r, 1, true) then
                    roots[#roots + 1] = r
                end
            end
        end
    end
    table.sort(roots, function(a, b)
        return #a > #b
    end)
    ---@type string?
    local root = roots[1]

    if not root then
        path = path and vim.fs.dirname(path) or vim.loop.cwd()
        ---@type string?
        root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
        root = root and vim.fs.dirname(root) or vim.loop.cwd()
    end
    ---@cast root string
    return root
end

function M.telescope(builtin, opts)
    local params = { builtin = builtin, opts = opts }

    return function()
        builtin = params.builtin
        opts = params.opts
        opts = vim.tbl_deep_extend('force', { cwd = M.get_root() }, opts or {})

        if builtin == 'files' then
            if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. '/.git') then
                opts.show_untracked = true
                builtin = 'git_files'
            else
                builtin = 'find_files'
            end
        end

        require('telescope.builtin')[builtin](opts)
    end
end

function M.lazy_notify()
    local notifs = {}

    local function temp(...)
        table.insert(notifs, vim.F.pack_len(...))
    end

    local orig = vim.notify
    vim.notify = temp

    local timer = vim.loop.new_timer()
    local check = vim.loop.new_check()

    local replay = function()
        timer:stop()
        check:stop()

        if vim.notify == temp then
            vim.notify = orig -- put back the original notify if needed
        end
        vim.schedule(function()
            ---@diagnostic disable-next-line: no-unknown
            for _, notif in ipairs(notifs) do
                vim.notify(vim.F.unpack_len(notif))
            end
        end)
    end

    -- wait till vim.notify has been replaced
    check:start(function()
        if vim.notify ~= temp then
            replay()
        end
    end)

    -- or if it took more than 500ms, then something went wrong
    timer:start(500, 0, replay)
end

function M.open_inspect_float()
    local bufnr = vim.api.nvim_create_buf(false, true)
    local items = vim.inspect_pos()

    local lines = { {} }

    ---@private
    local function append(str, hl)
        table.insert(lines[#lines], { str, hl })
    end

    ---@private
    local function nl()
        table.insert(lines, {})
    end

    ---@private
    local function item(data, comment)
        append('  - ')
        append(data.hl_group, data.hl_group)
        append(' ')
        if data.hl_group ~= data.hl_group_link then
            append('links to ', 'MoreMsg')
            append(data.hl_group_link, data.hl_group_link)
            append(' ')
        end
        if comment then
            append(comment, 'Comment')
        end
        nl()
    end

    -- treesitter
    if #items.treesitter > 0 then
        append('Treesitter', 'Title')
        nl()
        for _, capture in ipairs(items.treesitter) do
            item(capture, capture.lang)
        end
        nl()
    end

    -- semantic tokens
    if #items.semantic_tokens > 0 then
        append('Semantic Tokens', 'Title')
        nl()
        local sorted_marks = vim.fn.sort(items.semantic_tokens, function(left, right)
            local left_first = left.opts.priority < right.opts.priority
                or left.opts.priority == right.opts.priority and left.opts.hl_group < right.opts.hl_group
            return left_first and -1 or 1
        end)
        for _, extmark in ipairs(sorted_marks) do
            item(extmark.opts, 'priority: ' .. extmark.opts.priority)
        end
        nl()
    end

    -- syntax
    if #items.syntax > 0 then
        append('Syntax', 'Title')
        nl()
        for _, syn in ipairs(items.syntax) do
            item(syn)
        end
        nl()
    end

    -- extmarks
    if #items.extmarks > 0 then
        append('Extmarks', 'Title')
        nl()
        for _, extmark in ipairs(items.extmarks) do
            if extmark.opts.hl_group then
                item(extmark.opts, extmark.ns)
            else
                append('  - ')
                append(extmark.ns, 'Comment')
                nl()
            end
        end
        nl()
    end

    if #lines[#lines] == 0 then
        table.remove(lines)
    end

    local chunks = {}
    for _, line in ipairs(lines) do
        vim.list_extend(chunks, line)
        table.insert(chunks, { '\n' })
    end
    vim.print(chunks)

    vim.api.nvim_buf_set_lines(bufnr, 0, #lines, false, {})

    vim.api.nvim_open_win(bufnr, false, {
        relative = 'cursor',
        row = 0,
        col = 0,
        anchor = 'SW',
        focusable = false,
        border = BORDER,
    })
end

return M
