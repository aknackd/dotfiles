return {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			completion = { callSnippet = "Replace" },
			telemetry = { enabled = false },
			workspace = {
				checkThirdParty = false,
				library = {
					"${3rd}/luv/library",
					unpack(vim.api.nvim_get_runtime_file("", true)),
				},
			},
			-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
			-- diagnostics = { disable = { 'missing-fields' } },
		},
	},
}
