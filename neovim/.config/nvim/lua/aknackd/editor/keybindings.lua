map { "n", "<C-J>", ":cnext<CR>", noremap = true }       -- Navigate to next item in error list
map { "n", "<C-k>", ":cprev<CR>", noremap = true }       -- Navigate to previous item in error list
map { "t", "<Esc>", "<C-\\><C-n><CR>", noremap = true }  -- Escape from terminal mode
map { "n", "<Leader><Space>", ":nohlsearch<CR>", noremap = true, silent = true }
map { "n", "<Leader>s", ":sort u<CR>", noremap = true }
map { "v", "<Leader>s", ":sort u<CR>", noremap = true }

map { "n", "<tab>", "%", noremap = true }
map { "v", "<tab>", "%", noremap = true }

-- Tab management
map { "n", "<C-t>", ":tabe<CR>", noremap = true }           -- Open new tab
map { "n", "tl", ":tabnext<CR>", noremap = true }           -- Jump to next tab
map { "n", "th", ":tabprevious<CR>", noremap = true }       -- Jump to previous tab
map { "n", "<Leader>c", ":tabclose<CR>" }                   -- Close tab

-- Window management
map { "n", "gh", "<C-W>h" }                                 -- Move to window on the left
map { "n", "gl", "<C-W>l" }                                 -- Move to window on the right
map { "n", "gj", "<C-W>j" }                                 -- Move to window below
map { "n", "gk", "<C-W>k" }                                 -- Move to window above
map { "n", "gc", "<C-W>c" }                                 -- Close window
map { "n", "<Leader>w", ":wincmd w<CR>" }                   -- Jump to the below/right window of the current window - same as <CTRL-W w>
map { "n", "ts", ":split<SPACE>" }                          -- Open horizontal split
map { "n", "tv", ":vsplit<SPACE>" }                         -- Open vertical split
map { "n", "<Leader>v", "<C-W>v<SPACE>", noremap = true }   -- Open vertical split
map { "n", "+", "<c-w>5>", noremap = true }                 -- Increase window width
map { "n", "-", "<c-w>5<", noremap = true }                 -- Decrease window width

-- Keymaps for folke/trouble.nvim
map { "n", "<leader>xx", "<cmd>Trouble<cr>", silent = true, noremap = true }
map { "n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", silent = true, noremap = true }
map { "n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", silent = true, noremap = true }
map { "n", "<leader>xl", "<cmd>Trouble loclist<cr>",  silent = true, noremap = true }
map { "n", "<leader>xq", "<cmd>Trouble quickfix<cr>", silent = true, noremap = true }
map { "n", "gR", "<cmd>Trouble lsp_references<cr>", silent = true, noremap = true }

-- Keymaps for vim-easy-align
vim.cmd [[
	nmap ga <Plug>(EasyAlign)
	xmap ga <Plug>(EasyAlign)
]]
