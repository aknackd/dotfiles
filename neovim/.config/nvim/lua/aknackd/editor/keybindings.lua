map { "n", "<Leader>w", ":wincmd w<CR>" }                -- Jump to the below/right window of the current window - same as <CTRL-W w>
map { "n", "<C-J>", ":cnext<CR>", noremap = true }       -- Navigate to next item in error list
map { "n", "<C-k>", ":cprev<CR>", noremap = true }       -- Navigate to previous item in error list
map { "n", "<C-t>", ":tabe<CR>", noremap = true }        -- Open new tab
map { "n", "+", "<c-w>5>", noremap = true }              -- Increase window width
map { "n", "-", "<c-w>5<", noremap = true }              -- Decrease window width
map { "n", "<Leader>v", "<C-W>v<CR>", noremap = true }   -- Open vertical split
map { "t", "<Esc>", "<C-\\><C-n><CR>", noremap = true }  -- Escape from terminal mode
map { "n", "gl", ":tabnext<CR>", noremap = true }        -- Jump to next tab
map { "n", "gh", ":tabprevious<CR>", noremap = true }    -- Jump to previous tab
map { "n", "<Leader>c", "gcc" }                          -- Comment map
map { "x", "<leader>c", "gc" }                           -- Line comment

map { "n", "<Leader><Space>", ":nohlsearch<CR>", noremap = true, silent = true }
map { "n", "<Leader>s", ":sort u<CR>", noremap = true }
map { "v", "<Leader>s", ":sort u<CR>", noremap = true }

-- Keymaps for folke/trouble.nvim
map { "n", "<leader>xx", "<cmd>Trouble<cr>", silent = true, noremap = true }
map { "n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", silent = true, noremap = true }
map { "n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", silent = true, noremap = true }
map { "n", "<leader>xl", "<cmd>Trouble loclist<cr>",  silent = true, noremap = true }
map { "n", "<leader>xq", "<cmd>Trouble quickfix<cr>", silent = true, noremap = true }
map { "n", "gR", "<cmd>Trouble lsp_references<cr>", silent = true, noremap = true }

vim.cmd [[
	nmap ga <Plug>(EasyAlign)                   " vim-easy-align
	xmap ga <Plug>(EasyAlign)                   " vim-easy-align
	nnoremap <tab> >>                           " Tab to indent in normal mode
	nnoremap <S-tab> <<                         " Shift+Tab to de-indent in normal mode
	xnoremap <tab> >gv                          " Tab to indent in visual mode
	xnoremap <S-tab> <gv                        " Shift+Tab to de-indent in visual mode
]]
