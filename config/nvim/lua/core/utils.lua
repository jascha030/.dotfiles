local M = {}

M.root_patterns = { '.git', 'lua' }
local capabilities = vim.lsp.protocol.make_client_capabilities()

local default = {
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities),
    flags = { debounce_text = 150 },
}

function M.get_server_config(server_name)
    local ok, server_config = pcall(require, 'lsp.config.' .. server_name)

    if not ok then
        return vim.tbl_deep_extend('force', {}, default)
    end

    return vim.tbl_deep_extend('force', {}, default, server_config)
end

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            on_attach(client, buffer)
        end,
    })
end

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

return M
