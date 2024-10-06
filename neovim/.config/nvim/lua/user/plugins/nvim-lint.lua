local lint = require("lint")

lint.linters_by_ft = {
	markdown = { "vale" },
	javascript = { "biomejs" },
	typescript = { "biomejs" },
}

local lint_augroup = vim.api.nvim_create_augroup("nvim_lint_buf", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})
