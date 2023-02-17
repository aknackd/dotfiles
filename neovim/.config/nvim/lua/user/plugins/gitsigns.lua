require('gitsigns').setup({
	sign_priority = 20,
	on_attach = function(bufnr)
		vim.opt.signcolumn = 'yes:2'

		opts = { expr = true, buffer = bufnr }
		vim.keymap.set({ 'n', 'v' }, ']h', "&diff ? ']c' : ':Gitsigns next_hunk<CR>'", opts)
		vim.keymap.set({ 'n', 'v' }, '[h', "&diff ? ']c' : ':Gitsigns prev_hunk<CR>'", opts)
		vim.keymap.set('n', '<leader>gs', "&diff ? ']c' : ':Gitsigns stage_hunk<CR>'", opts)
		vim.keymap.set('n', '<leader>gS', "&diff ? ']c' : ':Gitsigns undo_stage_hunk<CR>'", opts)
	end,
})
