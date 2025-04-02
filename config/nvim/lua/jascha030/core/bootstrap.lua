local M = {}
local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

---@param name string
---@param alias string?
local function install_package(name, alias)
   -- print(string.format('Installing pkg: "%s"...', name))

    ---@type unknown, unknown, string, string
    local _, _, owner, repo = name:find([[(.+)/(.+)]])
    local path = ('%s/%s'):format(lazy_path, alias or repo)

    ---@diagnostic disable-next-line: undefined-field
    if not vim.loop.fs_stat(path) then
        vim.notify(('Installing %s/%s...'):format(owner, repo), vim.log.levels.INFO)

        local command = {
            'git',
            'clone',
            '--filter=blob:none',
            '--single-branch',
            ('https://github.com/%s/%s.git'):format(owner, repo),
            path,
        }

        vim.fn.system(command)
    end

    vim.opt.runtimepath:prepend(path)
end

---@param pkgs string | string[]
function M.install_packages(pkgs)
    if type(pkgs) == 'string' then
        return install_package(pkgs)
    end

    if type(pkgs) ~= 'table' then
        error('Invalid argument provided to install_packages(), must be table or string', 1)
    end

    for _, pkg in ipairs(pkgs) do
        M.install_packages(pkg)
    end
end

return M
