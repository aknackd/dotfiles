local env = require("user.utils").env

if env("NVIM_DISABLE_ARROW_KEYS", "false") == "true" then
	vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
	vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
	vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
	vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
end

vim.keymap.set("n", "<C-J>", ":cnext<CR>", { noremap = true, silent = true }) -- Navigate to next item in error list
vim.keymap.set("n", "<C-k>", ":cprev<CR>", { noremap = true, silent = true }) -- Navigate to previous item in error list
vim.keymap.set("t", "<Esc>", "<C-\\><C-n><CR>", { noremap = true }) -- Escape from terminal mode

vim.keymap.set("n", "<Esc>", "<esc>:nohlsearch<CR>", { noremap = true, silent = true }) -- Clear highlights
vim.keymap.set("n", "<Leader>s", ":sort u<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<Leader>s", ":sort u<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<tab>", "%", { noremap = true })
vim.keymap.set("v", "<tab>", "%", { noremap = true })

vim.keymap.set("v", "gq", "gw", { noremap = true }) -- "gw" seems more consistent than "gq" so always use the former when the latter is used

-- Tab management
-- vim.keymap.set("n", "<C-t>", ":tabnew<CR>", { noremap = true, silent = true }) -- Open new tab
-- vim.keymap.set("n", "tl", ":tabnext<CR>", { noremap = true, silent = true }) -- Jump to next tab
-- vim.keymap.set("n", "th", ":tabprevious<CR>", { noremap = true, silent = true }) -- Jump to previous tab
vim.keymap.set("n", "]t", ":tabnext<CR>", { noremap = true, silent = true }) -- Jump to next tab
vim.keymap.set("n", "[t", ":tabprevious<CR>", { noremap = true, silent = true }) -- Jump to previous tab

-- Stay on the same column with j/k when going up and down within wrapped text
vim.keymap.set("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true })
vim.keymap.set("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true })

-- Reselect visual mode selection after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "q:", ":q") -- Remap 'q:' typos to ':q'
vim.keymap.set("v", "p", '"_dP') -- Don't yank selected text when pasting in visual mode
vim.keymap.set("n", "c", '"_c') -- Don't yank when using "c" to replace (example: cw/ciw/caw/etc.)
vim.keymap.set("i", ";;", "<Esc>A;") -- Insert a semicolon at the end of the line when semicolon is pressed twice in insert mode
vim.keymap.set("i", ";;", "<Esc>A;") -- Insert a semicolon at the end of the line when semicolon is pressed twice in insert mode
vim.keymap.set("n", ";;", "<Esc>A;<Esc>") -- Same as above but when in normal mode
vim.keymap.set("i", ",,", "<Esc>A,") -- Insert a comma at the end of the
vim.keymap.set("n", ",,", "<Esc>A,<Esc>") -- Same as above but when in normal mode;

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>y", [["+y]]) -- Yank into system clipboard (only when inside tmux)
vim.keymap.set("v", "<leader>y", [["+y]]) -- Yank into system clipboard (only when inside tmux)
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Window management
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { silent = true }) -- CTRL+h - Move focus to window on the left
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { silent = true }) -- CTRL+l - Move focus to window on the right
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { silent = true }) -- CTRL+j - Move focus to window below
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { silent = true }) -- CTRL+k - Move focus to window above
vim.keymap.set("n", "<leader>w", ":wincmd w<CR>", { silent = true }) -- Jump to the below/right window of the current window - same as <CTRL-W w>
vim.keymap.set("n", "<leader>sH", "<Esc>:split<CR>", { noremap = true, silent = true }) -- Open horizontal split
vim.keymap.set("n", "<leader>sV", "<Esc>:vsplit<CR>", { noremap = true, silent = true }) -- Open vertical split
vim.keymap.set("n", "+", "<c-w>5>", { noremap = true }) -- Increase window width
vim.keymap.set("n", "-", "<c-w>5<", { noremap = true }) -- Decrease window width

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<Leader>bD", ":bufdo bd<CR>", { noremap = true }) -- deletes all buffers
