return {
	"aktersnurra/no-clown-fiesta.nvim",
	config = function()
		require("no-clown-fiesta").setup({
			transparent = false,
		})

		vim.opt.listchars = { space = "·", tab = "▸ ", trail = "·" }
	end,
}
