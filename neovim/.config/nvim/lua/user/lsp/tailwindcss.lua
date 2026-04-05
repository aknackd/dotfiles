local lsp = require("user.lsp")

lsp.setup("tailwindcss", {
	filetypes = {
		"astro",
		"blade",
		"handlebars",
		"html",
		"html.handlebars",
		"javascriptreact",
		"typescriptreact",
		"vue",
	},
	settings = {
		tailwindCSS = {
			includeLanguages = {
				templ = "html",
			},
		},
	},
})
