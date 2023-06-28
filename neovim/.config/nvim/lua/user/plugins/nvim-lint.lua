local lint = require('lint')

lint.linters_by_ft = {
	markdown = { 'vale' },
	javascript = { 'eslint_d' },
	typescript = { 'eslint_d' },
}

-- vim.api.nvim_create_augroup("nvim_lint_buf", { clear = true })

-- vim.api.nvim_create_autocmd("BufWritePost", {
-- 	group   = "nvim_lint_buf",
-- 	pattern = { "*.md", "*.js", "*.jsx", "*.tsx" },
-- 	callback = function() lint.try_lint() end,
-- })
