local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local previewers = require('telescope.previewers')
local sorters = require('telescope.sorters')


require('telescope').setup{
    defaults = {
		file_ignore_patterns = { '.git/', '.hg/', '.svn/', 'CVS/' },
		path_display = { truncate = 1 },
		selection_caret = '  ',
        color_devicons = true,
        prompt_prefix = ' 🔍 ',
        scroll_stragety = 'cycle',
        sorting_strategy = 'ascending',
		layout_config = {
			prompt_position = 'top',
		},

        file_sorter = sorters.get_fzy_sorter,

        file_previewer   = previewers.vim_buffer_cat.new,
        grep_previewer   = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,

        mappings = {
            i = {
				['<esc>'] = actions.close,
				['<C-Down>'] = actions.cycle_history_next,
				['<C-Up>'] = actions.cycle_history_prev,
                ['<C-x>'] = false,
            },
        },

		pickers = {
			find_files = {
				hidden = true,
			},
			buffers = {
				previewer = false,
				layout_config = {
					width = 80,
				},
			},
			oldfiles = {
				prompt_title = 'History',
			},
			lsp_references = {
				previewer = false,
			},
		},
    },
}

vim.keymap.set('n', '<C-g>', builtin.git_commits)
vim.keymap.set('n', '<C-p>', builtin.find_files)
vim.keymap.set('n', '<leader>b', builtin.buffers)
-- vim.keymap.set('n', '<leader>e', '<cmd>lua require("telescope.builtin").diagnostics({ bufnr = 0 })<CR>') -- diagnostics for the current buffer
vim.keymap.set('n', '<leader>E', builtin.diagnostics) -- workspace diagnostics
vim.keymap.set('n', '<leader>f', require('telescope').extensions.live_grep_args.live_grep_args)
vim.keymap.set('n', '<leader>F', '<cmd>lua require("telescope.builtin").find_files({ no_ignore = true, prompt_title = "All Files" })<CR>')
vim.keymap.set('n', '<leader>h', builtin.help_tags)
vim.keymap.set('n', '<leader>o', builtin.oldfiles)
vim.keymap.set('n', '<leader>s', builtin.lsp_document_symbols)
vim.keymap.set('n', '<leader>ps', function() builtin.grep_string({ search = vim.fn.input('Grep > ') }) end)
