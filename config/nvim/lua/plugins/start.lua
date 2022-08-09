local install_path = ('%s/site/pack/packer-lib/opt/packer.nvim'):format(vim.fn.stdpath('data'))

local function install_packer()
    vim.fn.termopen(('git clone https://github.com/wbthomason/packer.nvim %q'):format(install_path))
end

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    install_packer()
end

function _G.packer_upgrade()
    vim.fn.delete(install_path, 'rf')
    install_packer()
end

local packer = require('packer')
local utils = require('utils')
local spec = require('plugins')
local config = require('plugins.config')

local M = {}

function M.get_config(name, opts)
    local parts = utils.str_explode('/', name)

    name = parts[#parts]
    name = name:gsub('%.nvim', '')

    local m_ok, module = pcall(require, 'plugins.' .. name)

    if not m_ok then
        return function()
            local conf_ok, configuration = pcall(require, name)

            if not conf_ok then
                return
            end

            local ok, _ = pcall(configuration.setup, opts)

            if not ok then
                pcall(configuration.setup)
            end
        end
    end

    return function()
        local ok, _ = pcall(module, opts)

        if not ok then
            pcall(module)
        end
    end
end

-- Auto commands
vim.cmd([[packadd packer.nvim]], false)
vim.cmd([[autocmd BufWritePost plugins.lua PackerCompile]])
vim.cmd([[command! PackerUpgrade :call v:lua.packer_upgrade()]])

function M.setup()
    packer.startup({ spec, config = config })
end

return M
