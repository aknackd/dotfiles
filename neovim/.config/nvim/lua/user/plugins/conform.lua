local utils = require("user.utils")

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
			timeout_ms = utils.get_conform_timeout(),
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
		javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
		json = { "jq" },
		jsx = { "rustywind" },
		lua = { "stylua" },
		python = { "isort", "black" },
		sh = { "shfmt" },
		typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
		vue = { "rustywind" },
	},
})

vim.keymap.set("n", "<leader>f", function()
	-- Use the LSP's formatting if supported
	local buf_clients = vim.lsp.get_clients()
	for _, client in pairs(buf_clients) do
		if client.supports_method("textDocument/formatting") then
			vim.lsp.buf.format({ async = true })
			return
		end
	end

	-- Otherwise fallback to conform
	require("conform").format({ async = true, lsp_format = "fallback" })
end, {
	desc = "[F]ormat buffer",
})
