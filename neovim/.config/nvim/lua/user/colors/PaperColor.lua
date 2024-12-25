local utils = require("user.utils")

return {
	background = utils.get_background(),

	settings = {
		PaperColor_Theme_Options = {
			theme = {
				default = {
					transparent_background = utils.does_colorscheme_has_transparent_background(),
				},
			},
		},
	},

	highlights = {},

	setup = function() end,
}
