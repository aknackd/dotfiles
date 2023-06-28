vim.g['neoformat_try_node_exe'] = 1

vim.api.nvim_create_augroup("neoformat_buf", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group   = "neoformat_buf",
	pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.json" },
	command = "Neoformat",
})
