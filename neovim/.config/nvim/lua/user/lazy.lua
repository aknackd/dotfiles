local lazy_install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazy_install_path) then
	print("Installing lazy.nvim...")

	local stdout = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazy_install_path,
	})

	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. stdout)
	else
		print("Done!")
	end
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazy_install_path)

require("lazy").setup({
	{ import = "user.plugins" },
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will
		-- use the default lazy.nvim defined Nerd Font icons, otherwise define
		-- a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
