require('user.plugins.lualine')

local bufferline = require('bufferline')
local constants = require('bufferline.constants')

bufferline.setup({
	options = {
		mode = 'tabs',
		indicator = {
			icon = ' ',
		},
		enforce_regular_tabs = false,
		always_show_bufferline = true,
		show_close_icon = false,
		show_tab_indicators = true,
		-- @@@ Only close the tab if there's more than one tab
		-- @@@ The number of tabs can be retrieved via `tabpagenr('$')` in vimscript but there doesn't seem to be a way to do this in lua
		close_command = 'tabclose! %d',
		right_mouse_command = 'tabclose! %d',
		middle_mouse_command = 'tabclose! %d',
		tab_size = 0,
		max_name_length = 25,
		offsets = {},
		separator_style = constants.sep_names.slant,
		modified_icon = '',
		custom_areas = {
			left = function()
				return {
					{ text = '  ', fg = '#8fff6d' },
				}
			end,
		},
		diagnostics = 'nvim_lsp',
	},
	highlights = {
		fill = {
			bg = { attribute = 'bg', highlight = 'StatusLine' },
		},
		background = {
			bg = { attribute = 'bg', highlight = 'StatusLine' },
		},
		tab = {
			bg = { attribute = 'bg', highlight = 'StatusLine' },
		},
		tab_close = {
			bg = { attribute = 'bg', highlight = 'StatusLine' },
		},
		close_button = {
			bg = { attribute = 'bg', highlight = 'StatusLine' },
			fg = { attribute = 'fg', highlight = 'StatusLineNonText' },
		},
		close_button_visible = {
			bg = { attribute = 'bg', highlight = 'StatusLine' },
			fg = { attribute = 'fg', highlight = 'StatusLineNonText' },
		},
		close_button_selected = {
			fg = { attribute = 'fg', highlight = 'StatusLineNonText' },
		},
		buffer_visible = {
			bg = { attribute = 'bg', highlight = 'StatusLine' },
		},
		modified = {
			bg = { attribute = 'bg', highlight = 'StatusLine' },
		},
		modified_visible = {
			bg = { attribute = 'bg', highlight = 'StatusLine' },
		},
		duplicate = {
			bg = { attribute = 'bg', highlight = 'StatusLine' },
		},
		duplicate_visible = {
			bg = { attribute = 'bg', highlight = 'StatusLine' },
		},
		separator = {
			fg = { attribute = 'bg', highlight = 'StatusLine' },
			bg = { attribute = 'bg', highlight = 'StatusLine' },
		},
		separator_selected = {
			fg = { attribute = 'bg', highlight = 'StatusLine' },
			bg = { attribute = 'bg', highlight = 'Normal' }
		},
		separator_visible = {
			fg = { attribute = 'bg', highlight = 'StatusLine' },
			bg = { attribute = 'bg', highlight = 'StatusLine' },
		},
	},
})
