local utils = require("user.utils")

require("onedark").setup({
	style = "darker",
	transparent = utils.does_colorscheme_has_transparent_background(),
	code_style = {
		comments = "italic",
		keywords = "bold",
		functions = "bold",
	},
	lualine = {
		transparent = utils.does_colorscheme_has_transparent_background(),
	},
})

require("onedark").load()
