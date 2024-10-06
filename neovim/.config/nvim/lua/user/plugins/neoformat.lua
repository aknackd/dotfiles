local utils = require("user.utils")

vim.g["neoformat_try_node_exe"] = 1

local default_autoformat_filetypes = "*.js,*.ts,*.jsx,*.tsx,*.json,*.go,*.py"
local autoformat_filetypes = utils.split(",", utils.env("NVIM_NEOFORMAT_ON_SAVE", default_autoformat_filetypes))

vim.api.nvim_create_augroup("neoformat_buf", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = "neoformat_buf",
	pattern = autoformat_filetypes,
	command = "Neoformat",
})
