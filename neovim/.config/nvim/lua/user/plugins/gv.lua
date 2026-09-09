-- Plugin: gv.vim
-- Description: Browse a Git commit graph and history in a Vim buffer.
-- URL: https://github.com/junegunn/gv.vim
-- Documentation: https://github.com/junegunn/gv.vim#readme
-- Required Neovim: Not specified; Vim-compatible.
-- Language: Vimscript
-- Dependencies: tpope/vim-fugitive; Git.
-- User commands: :GV

return {
	"junegunn/gv.vim",
	dependencies = { "tpope/vim-fugitive" },
}
