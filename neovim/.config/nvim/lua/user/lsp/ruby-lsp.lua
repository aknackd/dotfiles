local lsp = require("user.lsp")

lsp.setup("ruby_lsp", {
	capabilities = {
		textDocument = { completion = { completionItem = { snippetSupport = true } } },
	},
	init_options = {
		addonSettings = {
			["Ruby LSP Rails"] = {
				enablePendingMigrationsPrompt = false,
			},
		},
		formatter = "standard",
		linters = { "standard" },
	},
})
