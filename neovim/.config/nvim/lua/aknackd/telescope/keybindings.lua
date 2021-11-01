map { "n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<CR>", noremap = true }
-- map { "n", "<C-t>", "<cmd>lua require('telescope.builtin').live_grep()<CR>", noremap = true }
map { "n", "<C-g>", "<cmd>lua require('telescope.builtin').git_commits()<CR>", noremap = true }

map { "n", "<Leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", noremap = true }
-- map { "n", "<Leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", noremap = true }
map { "n", "<Leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", noremap = true }
map { "n", "<Leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", noremap = true }
