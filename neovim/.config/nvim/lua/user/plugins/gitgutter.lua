return {
	"airblade/vim-gitgutter",
	config = function()
		vim.g["gitgutter_enabled"] = 1
		vim.g["gitgutter_realtime"] = 0
		vim.g["gitgutter_eager"] = 0
	end,
}
