return function()
	local telescope = require("telescope")
	local actions = require("telescope.actions")
	local themes = require("telescope.themes")

	local extension = telescope.load_extension
	local fb_actions = telescope.extensions.file_browser.actions

	telescope.setup({
		defaults = {
			set_env = { ["COLORTERM"] = "truecolor" },
			prompt_prefix = "   ",
			color_devicons = true,
			use_less = true,
			file_sorter = require("telescope.sorters").get_fzy_sorter,
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		},
		extensions = {
			["ui-select"] = {
				themes.get_dropdown,
			},
			fzy_native = {
				override_generic_sorter = false,
				override_file_sorter = true,
			},
			file_browser = {
				mappings = {
					["n"] = {
						["q"] = actions.close,
						["x"] = actions.delete_buffer,
						["d"] = fb_actions.remove,
					},
				},
			},
		},
	})

	extension("ui-select")
	extension("fzy_native")
	extension("file_browser")
end
