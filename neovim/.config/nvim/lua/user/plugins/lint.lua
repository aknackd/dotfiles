-- Plugin: nvim-lint
-- Description: Asynchronous linter runner for Neovim.
-- URL: https://github.com/mfussenegger/nvim-lint
-- Documentation: https://github.com/mfussenegger/nvim-lint#readme
-- Required Neovim: >= 0.9.5.
-- Language: Lua
-- Dependencies: External linter binaries, including oxlint and biome in this configuration.
-- User commands: None.

return {
	"mfussenegger/nvim-lint",
	config = function()
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
						lint.try_lint({ name })
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
	end,
}
