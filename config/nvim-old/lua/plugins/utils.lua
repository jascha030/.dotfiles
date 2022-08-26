local install_path = require('utils').data_dir() .. 'pack/packer-lib/opt/packer.nvim'
local create_cmd = vim.api.nvim_create_user_command

local function install_packer()
    vim.cmd([[packadd packer.nvim]])
    vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

function _G.packer_upgrade()
    vim.fn.delete(install_path, 'rf')
    install_packer()
end

local Packer = {}
Packer.__index = Packer

function Packer.install()
    local exists, _ = pcall(require, 'packer')

    if not exists then
        install_packer()
    end
end

function Packer.init_commands()
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

return Packer
