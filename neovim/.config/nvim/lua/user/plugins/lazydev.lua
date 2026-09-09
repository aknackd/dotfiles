-- Plugin: lazydev.nvim
-- Description: Fast Lua development support for Neovim configuration files.
-- URL: https://github.com/folke/lazydev.nvim
-- Documentation: https://github.com/folke/lazydev.nvim#readme
-- Required Neovim: >= 0.10.0.
-- Language: Lua
-- Dependencies: Bilal2453/luvit-meta; Lua language server (lua-language-server) for LSP completion.
-- User commands: :LazyDev

return {
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			{ path = "luvit-meta/library", words = { "vim%.uv" } },
		},
	},
	dependencies = {
		{ "Bilal2453/luvit-meta", lazy = true },
	},
}
