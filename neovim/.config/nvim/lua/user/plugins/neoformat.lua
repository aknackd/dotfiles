local split = require('user.utils').split

vim.g['neoformat_try_node_exe'] = 1

local default_autoformat_filetypes = "*.js,*.ts,*.jsx,*.tsx,*.json,*.go,*.py"
local autoformat_filetypes = split(",", os.getenv("NVIM_NEOFORMAT_ON_SAVE") or default_autoformat_filetypes)

vim.api.nvim_create_augroup("neoformat_buf", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group   = "neoformat_buf",
	pattern = autoformat_filetypes,
	command = "Neoformat",
})
