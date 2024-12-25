local utils = require("user.utils")

return {
	background = utils.get_background(),

	settings = {
		minimal_italic_functions = true,
		minimal_italic_comments = true,
		minimal_transparent_background = utils.does_colorscheme_has_transparent_background(),
	},

	highlights = {
		{ group = "Comment", options = { fg = "#999999" } },
		{ group = "IndentBlanklineSpaceChar", options = { fg = "#444444" } },
	},

	setup = function() end,
}
