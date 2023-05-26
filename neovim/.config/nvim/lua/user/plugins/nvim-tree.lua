-- Disable netrw
vim.g['loaded_netrw'] = 1
vim.g['loaded_netrwPlugin'] = 1

vim.keymap.set('n', '<leader>ne', ':NvimTreeToggle<CR>')

require('nvim-tree').setup({
	sort_by = 'case_sensitive',
	view = {
		width = 40,
		side = 'left',
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
})
