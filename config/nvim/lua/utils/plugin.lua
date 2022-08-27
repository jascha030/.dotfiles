local Plugin = {}

local cmds_loaded = false
local data_dir = string.format("%s/site", vim.fn.stdpath("data"))
local install_path = data_dir .. "pack/packer-lib/opt/packer.nvim"

function Plugin.packer_install()
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

function Plugin.create_cmds()
	if cmd_loaded == true then
		return
	end

    local create_cmd = vim.api.nvim_create_user_command
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

return Plugin
