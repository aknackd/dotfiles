local split = require('user.utils').split

vim.g['neoformat_try_node_exe'] = 1

local default_autoformat_fts = "*.js,*.ts,*.jsx,*.tsx,*.json,*.go,*.py"

vim.api.nvim_create_augroup("neoformat_buf", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group   = "neoformat_buf",
	pattern = split(",", os.getenv("NVIM_NEOFORMAT_ON_SAVE") or default_autoformat_fts),
	command = "Neoformat",
})
