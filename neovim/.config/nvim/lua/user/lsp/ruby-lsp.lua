return {
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
}
