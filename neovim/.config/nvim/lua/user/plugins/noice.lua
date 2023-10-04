vim.opt.lazyredraw = false

require('noice').setup({
	routes = {
		{
			filter = { event = 'msg_show', kind = '', find = 'written' },
			opts = { skip = true },
		},
		{
			filter = { event = 'msg_show', kind = '', find = '; before' },
			opts = { skip = true },
		},
		{
			filter = { event = 'msg_show', kind = '', find = '; after' },
			opts = { skip = true },
		},
		{
			filter = { event = 'msg_show', kind = '', find = 'Already at oldest change' },
			opts = { skip = true },
		},
		{
			filter = { event = 'msg_show', kind = '', find = 'Already at newest change' },
			opts = { skip = true },
		},
	},
	cmdline = {
		enabled = true,
		view = 'cmdline',
	},
	lsp = {
		override = {
			['vim.lsp.util.convert_input_to_markdown_lines'] = true,
			['vim.lsp.util.stylize_markdown'] = true,
			['cmp.entry.get_documentation'] = true,
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = false,
	},
})
