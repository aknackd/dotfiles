-- Plugin: indent-blankline.nvim
-- Description: Add indentation guides to Neovim.
-- URL: https://github.com/lukas-reineke/indent-blankline.nvim
-- Documentation: https://github.com/lukas-reineke/indent-blankline.nvim#readme
-- Required Neovim: >= 0.8.0.
-- Language: Lua
-- Dependencies: None.
-- User commands: :IBLEnable, :IBLDisable, :IBLToggle, :IBLEnableScope, :IBLDisableScope, :IBLToggleScope

return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		require("ibl").setup({
			exclude = {
				filetypes = {
					"help",
					"terminal",
					"dashboard",
					"packer",
					"lspinfo",
					"TelescopePrompt",
					"TelescopeResults",
				},
				buftypes = {
					"terminal",
					"NvimTree",
				},
			},
		})
	end,
}
