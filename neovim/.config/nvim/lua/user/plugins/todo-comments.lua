-- Plugin: todo-comments.nvim
-- Description: Highlight and search TODO-style comments.
-- URL: https://github.com/folke/todo-comments.nvim
-- Documentation: https://github.com/folke/todo-comments.nvim#readme
-- Required Neovim: >= 0.8.0.
-- Language: Lua
-- Dependencies: plenary.nvim; optional Telescope, Trouble, or fzf-lua; ripgrep for search.
-- User commands: :TodoQuickFix, :TodoLocList, :TodoTelescope, :TodoFzfLua, :TodoTrouble

return {
	"folke/todo-comments.nvim",
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = { signs = false },
}
