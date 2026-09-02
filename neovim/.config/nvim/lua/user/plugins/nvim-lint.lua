local lint = require("lint")

local preferred_linters = { "oxlint", "biomejs" }
local lint_filetypes = {
	javascript = true,
	javascriptreact = true,
	typescript = true,
	typescriptreact = true,
}

local function try_preferred_linter()
	if not lint_filetypes[vim.bo.filetype] then
		return
	end

	for _, name in ipairs(preferred_linters) do
		local linter = lint.linters[name]
		if linter then
			local cmd = linter.cmd
			if type(cmd) == "function" then
				cmd = cmd()
			end
			if type(cmd) == "table" then
				cmd = cmd[1]
			end
			if cmd and vim.fn.executable(cmd) == 1 then
				lint.try_lint({ linters = { name } })
				return
			end
		end
	end
end

local lint_augroup = vim.api.nvim_create_augroup("nvim_lint_buf", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		try_preferred_linter()
	end,
})
