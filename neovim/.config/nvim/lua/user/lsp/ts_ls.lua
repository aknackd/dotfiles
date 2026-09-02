local ts_ls_inlay_hints = {
	includeInlayEnumMemberValueHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayFunctionParameterTypeHints = true,
	includeInlayParameterNameHints = "all",
	includeInlayParameterNameHintsWhenArgumentMatchesName = true,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayVariableTypeHints = true,
	includeInlayVariableTypeHintsWhenTypeMatchesName = true,
}

local lsp = require("user.lsp")
local typescript = require("user.lsp.shared.typescript")

lsp.setup("ts_ls", {
	root_dir = typescript.classic_root_dir,
	settings = {
		maxts_lsMemory = 12288,
		typescript = {
			inlayHints = ts_ls_inlay_hints,
		},
		javascript = {
			inlayHints = ts_ls_inlay_hints,
		},
	},
})
