-- Plugin: vim-easy-align
-- Description: Interactive alignment of text around a delimiter.
-- URL: https://github.com/junegunn/vim-easy-align
-- Documentation: https://github.com/junegunn/vim-easy-align/blob/master/doc/easy_align.txt
-- Required Neovim: Not specified; Vim-compatible.
-- Language: Vimscript
-- Dependencies: None.
-- User commands: :EasyAlign, :LiveEasyAlign

return {
	"junegunn/vim-easy-align",
	config = function()
		vim.cmd([[
	nmap ga <Plug>(EasyAlign)
	xmap ga <Plug>(EasyAlign)
]])
	end,
}
