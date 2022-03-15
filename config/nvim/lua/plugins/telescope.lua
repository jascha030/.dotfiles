local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		prompt_prefix = " > ",
		color_devicons = true,
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" },
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
		file_browser = {},
	},
})

require("telescope").load_extension("fzy_native")
require("telescope").load_extension("file_browser")
