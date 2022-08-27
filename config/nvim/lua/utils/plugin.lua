local M = {}

local cmds_loaded = false
local create_cmd = vim.api.nvim_create_user_command
local data_dir = string.format("%s/site", vim.fn.stdpath("data"))
local install_path = data_dir .. "pack/packer-lib/opt/packer.nvim"

function M.packer_install()
	vim.cmd([[packadd packer.nvim]])
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

function M.create_cmds()
	if cmd_loaded == true then
		return
	end

	cmd_loaded = true

	create_cmd("PackerInstall", function()
		vim.cmd([[packadd packer.nvim]])
		require("plugins").install()
	end, {})

	create_cmd("PackerUpdate", function()
		vim.cmd([[packadd packer.nvim]])
		require("plugins").update()
	end, {})

	create_cmd("PackerSync", function()
		vim.cmd([[packadd packer.nvim]])
		require("plugins").sync()
	end, {})

	create_cmd("PackerClean", function()
		vim.cmd([[packadd packer.nvim]])
		require("plugins").clean()
	end, {})

	create_cmd("PackerCompile", function()
		vim.cmd([[packadd packer.nvim]])
		require("plugins").compile()
	end, {})
end

return M
