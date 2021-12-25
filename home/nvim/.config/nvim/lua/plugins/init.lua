local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
local execute = vim.api.nvim_command

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
    execute 'packadd packer.nvim'
end

require('plugins.packer')

-- Plugin Configs
require('plugins.treesitter')
require('plugins.nvim-compe')
require('plugins.lualine')
require('plugins.nvim-tree')
-- require('plugins.telescope')

