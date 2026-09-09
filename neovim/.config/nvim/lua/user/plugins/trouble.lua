-- Plugin: trouble.nvim
-- Description: Pretty lists for diagnostics, references, quickfix, and location lists.
-- URL: https://github.com/folke/trouble.nvim
-- Documentation: https://github.com/folke/trouble.nvim#readme
-- Required Neovim: >= 0.9.2; Markdown parsers or Neovim >= 0.10 for Markdown rendering.
-- Language: Lua
-- Dependencies: Properly configured LSP client; optional nvim-web-devicons.
-- User commands: :Trouble

return {
	"folke/trouble.nvim",
	config = function()
		require("trouble").setup()

		vim.keymap.set("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true, noremap = true })
		vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
		vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { silent = true, noremap = true })
		vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
		vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
		vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
	end,
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
	},
}
