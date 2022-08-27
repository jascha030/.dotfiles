local packer = nil

function init()
	if not packer then
		vim.cmd([[packadd packer.nvim]])
		packer = require("packer")
	end

	packer.init({
		disable_commands = true,
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
		profile = {
			enable = true,
			threshold = 1,
		},
	})
	local use = packer.use
	packer.reset()

	use({ "wbthomason/packer.nvim", opt = true })
    use({ 'wakatime/vim-wakatime' })

end

local plugins = setmetatable({}, {
	__index = function(_, key)
		init()
		return packer[key]
	end,
})

return plugins
