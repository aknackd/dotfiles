local capabilities = vim.lsp.protocol.make_client_capabilities()
local lsp = require("user.lsp")

capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp.setup("emmet_ls", {
	capabilities = capabilities,
	filetypes = {
		"blade",
		"css",
		"eruby",
		"html",
		"javascript",
		"javascriptreact",
		"less",
		"pug",
		"sass",
		"scss",
		"svelte",
		"typescriptreact",
		"vue",
	},
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
		},
	},
})
