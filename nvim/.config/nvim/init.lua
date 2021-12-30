--[[===========================Jascha030's==============================--
--   __  __  __  __  ______                __       __  __  ______      --
--  /\ \/\ \/\ \/\ \/\__  _\   /'\_/`\    /\ \     /\ \/\ \/\  _  \     --
--  \ \ `\\ \ \ \ \ \/_/\ \/  /\      \   \ \ \    \ \ \ \ \ \ \L\ \    --
--   \ \ , ` \ \ \ \ \ \ \ \  \ \ \__\ \   \ \ \  __\ \ \ \ \ \  __ \   --
--    \ \ \`\ \ \ \_/ \ \_\ \__\ \ \_/\ \   \ \ \L\ \\ \ \_\ \ \ \/\ \  --
--     \ \_\ \_\ `\___/ /\_____\\ \_\\ \_\   \ \____/ \ \_____\ \_\ \_\ --
--      \/_/\/_/`\/__/  \/_____/ \/_/ \/_/    \/___/   \/_____/\/_/\/_/ --
--                                                                      --
--============================Configuration===========================]]--


--[[Variable and Table definitions]]

-- Shortcuts
local cmd = vim.cmd
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
local execute = vim.api.nvim_command

-- vim option scopes
local scopes = {
    g = vim.g,
    o = vim.o,
    b = vim.bo,
    w = vim.wo,
    opt = vim.opt
}

--[[Functions]]

-- Set options per scope in a loop
local set_options_per_scope = function(option_scopes, options)
    for option_scope, option_list in pairs(options) do
        for option_key, option_value in pairs(option_list) do
            option_scopes[option_scope][option_key] = option_value
        end
    end
end

--[[Execute init logic]]

-- Install Packer if not available
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
    execute 'packadd packer.nvim'
end

-- Set listed options from options module per scope
set_options_per_scope(scopes, require 'options')

-- Auto commands
cmd([[autocmd BufWritePost packer.lua PackerCompile]])
-- Load packer
cmd([[packadd packer.nvim]], false)
-- Set colorscheme
cmd([[colorscheme tokyonight]])


-- [[require modules]]

-- Packer startup logic & installed plugins list
require 'packer-plugins'
-- Plugin module containing plugin configurations
require 'plugins'
-- Keymap module
require 'keymap'
