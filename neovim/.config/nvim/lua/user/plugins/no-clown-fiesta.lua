-- Plugin: no-clown-fiesta.nvim
-- Description: A dark, colorful Neovim colorscheme.
-- URL: https://github.com/aktersnurra/no-clown-fiesta.nvim
-- Documentation: https://github.com/aktersnurra/no-clown-fiesta.nvim#readme
-- Required Neovim: Not specified; modern Neovim recommended.
-- Language: Lua
-- Dependencies: None.
-- User commands: None.

return {
	"aktersnurra/no-clown-fiesta.nvim",
	config = function()
		require("no-clown-fiesta").setup({
			transparent = false,
		})

		vim.opt.listchars = { space = "·", tab = "▸ ", trail = "·" }
	end,
}
