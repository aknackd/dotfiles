return {
	"famiu/bufdelete.nvim",
	config = function()
		vim.keymap.set("n", "<Leader>q", ":Bdelete<CR>")
	end,
}
