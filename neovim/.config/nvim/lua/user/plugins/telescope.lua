local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")

require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_ivy(), -- get_dropdown(),
		},
	},
	defaults = {
		file_ignore_patterns = { ".git/", ".hg/", ".svn/", "CVS/" },
		path_display = { truncate = 1 },
		selection_caret = "  ",
		color_devicons = true,
		prompt_prefix = " 🔍 ",
		scroll_stragety = "cycle",
		sorting_strategy = "ascending",
		layout_config = { prompt_position = "bottom" },
		file_sorter = sorters.get_fzy_sorter,

		file_previewer = previewers.vim_buffer_cat.new,
		grep_previewer = previewers.vim_buffer_vimgrep.new,
		qflist_previewer = previewers.vim_buffer_qflist.new,

		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-Down>"] = actions.cycle_history_next,
				["<C-Up>"] = actions.cycle_history_prev,
				["<C-x>"] = false,
			},
		},

		pickers = {
			find_files = {
				hidden = true,
			},
			oldfiles = {
				prompt_title = "History",
			},
			lsp_references = {
				previewer = false,
			},
			buffers = {
				previewer = false,
				layout_config = {
					width = 80,
				},
			},
		},
	},
})

-- Enable Telescope extensions if they are installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sF", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sS", builtin.lsp_document_symbols, { desc = "[S]how LSP symbols" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader>sE", builtin.diagnostics, { desc = "[W]orkspace [D]iagnostics" })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

vim.keymap.set("n", "<C-g>", builtin.git_commits, { desc = "[S]how [Git] commits" })
vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "[S]earch [F]iles" })

-- vim.keymap.set("n", "<leader>f", require("telescope").extensions.live_grep_args.live_grep_args)
-- vim.keymap.set("n", "<leader>sF", function()
-- 	require("telescope.builtin").find_files({ no_ignore = true, prompt_title = "All Files" })
-- end, { desc = "[S]earch [A]ll [F]iles" })

vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
