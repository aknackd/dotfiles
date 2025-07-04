vim.opt.lazyredraw = false

require("noice").setup({
	routes = {
		-- Move undo/redo messages to the "mini" view
		{
			filter = {
				event = "msg_show",
				any = {
					{ find = "%d+L, %d+B" },
					{ find = "; after #%d+" },
					{ find = "; before #%d+" },
					{ find = "Already at oldest change" },
					{ find = "Already at newest change" },
				},
			},
			view = "mini",
		},
		-- Don't show yank/paste/delete messages
		{
			filter = {
				event = "msg_show",
				any = {
					{ find = "%d lines yanked" },
					{ find = "%d fewer lines" },
					{ find = "%d more lines" },
					{ find = "No lines in buffer" },
				},
			},
			opts = { skip = true },
		},
		{
			filter = {
				any = {
					{ find = "nil" },
					{ find = "No information available" },
					-- Messages emitted by jdtls
					{ find = "Starting Java Language Server" },
					{ find = "OK" },
					{ find = "Ready" },
					{ find = "ServiceReady" },
				},
			},
			opts = { skip = true },
		},
		-- Don't show annoying messages
		{
			filter = {
				any = {
					{ find = "client.supports_method is deprecated" },
					{ find = "syntax/java.vim: " },
				},
			},
			opts = { skip = true },
		},
		-- Don't show progress messages from jdtls
		-- https://github.com/LazyVim/LazyVim/discussions/1439#discussioncomment-6971647
		{
			filter = {
				event = "lsp",
				kind = "progress",
				find = "jdtls",
			},
			opts = { skip = true },
		},
		-- Route any messages with more than 20 lines to a split
		{
			filter = { event = "msg_show", min_height = 20 },
			view = "split",
		},
	},
	cmdline = {
		enabled = true,
		view = "cmdline",
	},
	lsp = {
		progress = {
			enabled = false,
		},
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = true,
	},
})
