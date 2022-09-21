local Utils = {}

local cmds_loaded = false

function Utils.wrap(fnc, ...)
    local params = { ... }

    if type(fnc) ~= 'function' then
        local prev = fnc

        fnc = function(...)
            return prev
        end
    end

    return function()
        return fnc(unpack(params))
    end
end

local function safe_load(m)
    local ok, res = pcall(require, m)

    return ok, res
end

function Utils.check_deps(list)
    for _, v in ipairs(list) do
        if not safe_load(v) then
            return false, v
        end
    end

    return true, list
end

function Utils.validate(list, where)
    local ok, v = Utils.check_deps(list)

    if not ok then
        error('Error initializing ' .. where .. ': missing dependency: "' .. v .. '.')
    end

    return ok
end

function Utils.str_explode(delimiter, p)
    local tbl, position = {}, 0

    if #p == 1 then
        return { p }
    end

    while true do
        local l = string.find(p, delimiter, position, true)

        if l ~= nil then
            table.insert(tbl, string.sub(p, position, l - 1))
            position = l + 1
        else
            table.insert(tbl, string.sub(p, position))

            break
        end
    end

    return tbl
end

local install_path = ('%s/site/pack/packer-lib/opt/packer.nvim'):format(vim.fn.stdpath('data'))

local function packer_install()
    vim.fn.termopen(('git clone https://github.com/wbthomason/packer.nvim %q'):format(install_path))
end

function Utils.assert_packer()
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        packer_install()
    end
end

function _G.packer_upgrade()
    vim.fn.delete(install_path, 'rf')
    packer_install()
end

vim.cmd([[command! PackerUpgrade :call v:lua.packer_upgrade()]])

function Utils.create_packer_cmds()
    if cmds_loaded == true then
        return
    end

    local create_cmd = vim.api.nvim_create_user_command
    cmds_loaded = true

    create_cmd('PackerInstall', function()
        vim.cmd([[packadd packer.nvim]])
        require('plugins').install()
    end, {})

    create_cmd('PackerUpdate', function()
        vim.cmd([[packadd packer.nvim]])
        require('plugins').update()
    end, {})

    create_cmd('PackerSync', function()
        vim.cmd([[packadd packer.nvim]])
        require('plugins').sync()
    end, {})

    create_cmd('PackerClean', function()
        vim.cmd([[packadd packer.nvim]])
        require('plugins').clean()
    end, {})

    create_cmd('PackerCompile', function()
        vim.cmd([[packadd packer.nvim]])
        require('plugins').compile('profile=true')
        -- require('plugins').compile()
        vim.cmd([[:LuaCacheClear]])
    end, {})

    create_cmd('PackerProfile', function()
        vim.cmd([[packadd packer.nvim]])

        require('plugins').profile_output()
    end, {})
end

function Utils.get_width()
    return vim.api.nvim_list_uis()[1].width
end

function Utils.get_height()
    return vim.api.nvim_list_uis()[1].height
end

Utils = setmetatable(Utils, {
    __index = function(_, key)
        local ok, submod = pcall(require, 'utils.' .. key)

        return ok and submod or nil
    end,
})

return Utils
