return {
	background = 'dark',

	settings = {},

	highlights = {},

	setup = function()
		require('kanagawa').setup({
			theme = 'default',
			undercurl = false,
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true},
			statementStyle = { bold = true },
			typeStyle = {},
			variablebuiltinStyle = { italic = true},
			specialReturn = true,       -- special highlight for the return keyword
			specialException = true,    -- special highlight for exception handling keywords
			transparent = false,        -- do not set background color
			dimInactive = true,        -- dim inactive window `:h hl-NormalNC`
			globalStatus = true,       -- adjust window separators highlight for laststatus=3
			terminalColors = true,      -- define vim.g.terminal_color_{0,17}
			colors = {},
			overrides = {},
		})
	end,
}
