-- Mostly taken from
-- https://www.reddit.com/r/neovim/comments/u9ihdt/comment/i5v41e6
-- https://www.reddit.com/r/neovim/comments/u9ihdt/comment/i5sk5ug

vim.api.nvim_create_augroup("bufcheck", { clear = true })

-- Reload nvim config when changed
vim.api.nvim_create_autocmd("BufWritePost", {
	group   = "bufcheck",
	pattern = vim.env.MYVIMRC,
	command = "silent source %",
})

-- Start :term in INSERT mode
vim.api.nvim_create_autocmd("TermOpen", {
	group   = "bufcheck",
	pattern = "*",
	command = "startinsert | set winfixheight",
})

-- Setup emmet on specific filetypes
vim.api.nvim_create_autocmd("FileType", {
	group   = "bufcheck",
	pattern = { "html", "css", "blade", "vue" },
	command = "EmmetInstall"
})

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

-- Enable spell checking on certain filenames
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "CONTRIBUTORS", "COPYING", "HACKING", "INSTALL", "LICENSE", "NEWS", "README", "UPGRADING" },
	callback = aknackd_enable_spellcheck,
})

-- Enable spell checking on certain filetypes
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "asciidoc", "markdown", "text", "rst" },
	callback = aknackd_enable_spellcheck,
})
