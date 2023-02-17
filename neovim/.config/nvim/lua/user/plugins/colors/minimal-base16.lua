return {
	background = 'dark',

	settings = {
		minimal_italic_functions = true,
		minimal_italic_comments = true,
		minimal_transparent_background = true,
	},

	highlights = {
		{ group = 'Comment', options = { fg = '#999999' } },
		{ group = 'IndentBlanklineSpaceChar', options = { fg = '#444444' } },
	},

	setup = function()
	end,
}
