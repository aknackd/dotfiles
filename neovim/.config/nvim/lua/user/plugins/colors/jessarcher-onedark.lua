return {
	background = 'dark',

	settings = {
		onedark_termcolors = 256,
		onedark_hide_endofbuffer = true,
		onedark_terminal_italics = true,
	},

	highlights = {
		-- Hide the characters in FloatBorder
		{ group = 'FloatBorder', options = {
			fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
			bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
		}},
		-- Make the StatusLineNonText background the same as StatusLine
		{ group = 'StatusLineNonText', options = {
			fg = vim.api.nvim_get_hl_by_name('NonText', true).foreground,
			bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
		}},
		-- Hide the characters in CursorLineBg
		{ group = 'CursorLineBg', options = {
			fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
			bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
		}},
		{ group = 'NvimTreeIndentMarker', options = { fg = '#30323E' }},
		{ group = 'IndentBlanklineChar',  options = { fg = '#2F313C' }},
	},

	setup = function()
	end,
}

