-- Plugin: bufdelete.nvim
-- Description: Delete buffers without disrupting the window layout.
-- URL: https://github.com/famiu/bufdelete.nvim
-- Documentation: https://github.com/famiu/bufdelete.nvim#readme
-- Required Neovim: Latest stable release recommended.
-- Language: Lua
-- Dependencies: None.
-- User commands: :Bdelete, :Bwipeout

return {
	"famiu/bufdelete.nvim",
	config = function()
		vim.keymap.set("n", "<Leader>q", ":Bdelete<CR>")
	end,
}
