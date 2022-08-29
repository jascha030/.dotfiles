local Plugin = {}
local cmds_loaded = false
local install_path = ('%s/site/pack/packer-lib/opt/packer.nvim'):format(vim.fn.stdpath('data'))

local function packer_install()
    vim.fn.termopen(('git clone https://github.com/wbthomason/packer.nvim %q'):format(install_path))
end

function Plugin.packer_init()
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        packer_install()
    end

    vim.cmd([[packadd packer.nvim]])

    function _G.packer_upgrade()
        vim.fn.delete(install_path, 'rf')

        packer_install()
    end

    vim.cmd([[command! PackerUpgrade :call v:lua.packer_upgrade()]])
end

function Plugin.create_cmds()
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
        require('plugins').compile()
    end, {})
end

return Plugin
