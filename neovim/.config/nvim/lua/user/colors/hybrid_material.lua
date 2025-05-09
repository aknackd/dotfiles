local utils = require("user.utils")

return {
	background = utils.get_background(),

	settings = {
		hybrid_transparent_background = utils.does_colorscheme_has_transparent_background(),
	},

	highlights = {},

	setup = function() end,
}
