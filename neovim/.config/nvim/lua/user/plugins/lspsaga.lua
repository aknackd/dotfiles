local has_feature = require('user.utils').has_feature

if has_feature('lsp') == false then return end

require('lspsaga').setup({
	preview = {
		lines_above = 0,
		lines_below = 10,
	},
	scroll_preview = {
		scroll_down = '<C-f>',
		scroll_up = '<C-b>',
	},
	request_timeout = 2000,
	finder = {
		edit = { 'o', '<CR>' },
		vsplit = 's',
		split = 'i',
		tabe = 't',
		quit = { 'q', '<ESC>' },
	},
	definition = {
		edit = '<C-c>o',
		vsplit = '<C-c>v',
		split = '<C-c>i',
		tabe = '<C-c>t',
		quit = { 'q', '<ESC>', '<C-c>' },
		close = '<Esc>',
	},
	code_action = {
		num_shortcut = true,
		keys = {
			quit = { 'q', '<ESC>', '<C-c>' },
			exec = '<CR>',
		},
	},
	lightbulb = {
		enable = true,
		enable_in_insert = true,
		sign = true,
		sign_priority = 40,
		virtual_text = true,
	},
	diagnostic = {
		twice_into = false,
		show_code_action = true,
		show_source = true,
		keys = {
			exec_action = 'o',
			quit = { 'q', '<ESC>', '<C-c>' },
		},
	},
	rename = {
		quit = { 'q', '<ESC>', '<C-c>' },
		exec = '<CR>',
		in_select = true,
	},
	outline = {
		win_position = 'right',
		win_with = '',
		win_width = 30,
		show_detail = true,
		auto_preview = true,
		auto_refresh = true,
		auto_close = true,
		custom_sort = nil,
		keys = {
			jump = 'o',
			expand_collapse = 'u',
			quit = { 'q', '<ESC>', '<C-c>' },
		},
	},
	callhierarchy = {
		show_detail = false,
		keys = {
			edit = 'e',
			vsplit = 's',
			split = 'i',
			tabe = 't',
			jump = 'o',
			quit = 'q',
			expand_collapse = 'u',
		},
	},
	symbol_in_winbar = {
		enable = false,
		separator = ' ',
		hide_keyword = true,
		show_file = true,
		folder_level = 2,
	},
	ui = {
		title = false,
		border = 'rounded',
		winblend = 0,
		expand = '',
		collapse = '',
		preview = ' ',
		code_action = '💡',
		diagnostic = '🐞',
		incoming = ' ',
		outgoing = ' ',
		colors = {
			normal_bg = '#1d1536',
			title_bg = '#afd700',
			red = '#e95678',
			magenta = '#b33076',
			orange = '#FF8700',
			yellow = '#f7bb3b',
			green = '#afd700',
			cyan = '#36d0e0',
			blue = '#61afef',
			purple = '#CBA6F7',
			white = '#d1d4cf',
			black = '#1c1c19',
		},
		kind = {},
	},
})

local opts = { silent = true }

vim.keymap.set('n', '<leader>gd', '<cmd>Lspsaga goto_definition<CR>', opts)
vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts)
vim.keymap.set('n', '<leader>ld', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
vim.keymap.set('n', '<leader>e', '<cmd>Lspsaga show_buf_diagnostics<CR>', opts)
vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', '<leader>t', '<cmd>Lspsaga term_toggle<CR>', opts)
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
