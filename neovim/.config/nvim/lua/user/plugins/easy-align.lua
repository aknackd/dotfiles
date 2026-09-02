return {
	"junegunn/vim-easy-align",
	config = function()
		vim.cmd([[
	nmap ga <Plug>(EasyAlign)
	xmap ga <Plug>(EasyAlign)
]])
	end,
}
