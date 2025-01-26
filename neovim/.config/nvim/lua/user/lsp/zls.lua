local lspconfig = require("lspconfig")

return {
	root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
	settings = {
		zls = {
			enable_build_on_save = false,
			enable_inlay_hints = true,
			warn_style = true,
		},
	},
}
