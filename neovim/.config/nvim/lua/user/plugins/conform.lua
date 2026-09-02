return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	config = function()
		local ignore_filetypes = { "c", "cpp", "java" }

		require("conform").setup({
			notify_on_error = false,

			format_on_save = function(bufnr)
				if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
					return
				end

				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end

				local ft = vim.bo.filetype
				local bufname = vim.api.nvim_buf_get_name(bufnr)

				-- Don't ever try to reformat anything in node_modules
				if bufname:match("/node_modules/") then
					return
				end

				-- The same goes for vendor/ but only for PHP files
				if bufname:match("/vendor/") and ft == "php" then
					return
				end

				return {
					timeout_ms = 2500,
					lsp_format = "fallback",
				}
			end,

			formatters = {
				shfmt = {
					prepend_args = { "-i", "4" },
				},
			},

			formatters_by_ft = {
				blade = { "blade-formatter", "rustywind" },
				go = { "goimports", "goimports-reviser" },
				html = { "rustywind" },
				javascript = { "oxfmt", "biome", "prettierd", "prettier", stop_after_first = true },
				json = { "jq" },
				javascriptreact = { "oxfmt", "biome", "prettierd", "prettier", stop_after_first = true },
				jsx = { "rustywind" },
				lua = { "stylua" },
				python = { "isort", "black" },
				sh = { "shfmt" },
				typescript = { "oxfmt", "biome", "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "oxfmt", "biome", "prettierd", "prettier", stop_after_first = true },
				vue = { "rustywind" },
			},
		})

		vim.keymap.set("n", "<leader>f", function()
			-- Prefer configured formatters and use LSP formatting only as a fallback.
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, {
			desc = "[F]ormat buffer",
		})
	end,
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
