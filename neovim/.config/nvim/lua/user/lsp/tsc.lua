local lsp = require("user.lsp")
local typescript = require("user.lsp.shared.typescript")

lsp.setup("tsc", {
	cmd = { "node_modules/.bin/tsc", "--lsp", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_dir = typescript.native_root_dir,
})
