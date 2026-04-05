local utils = require("user.utils")
local lsp = require("user.lsp")

lsp.setup("intelephense", {
	init_options = {
		globalStoragePath = utils.get_lsp_cache_dir() .. "/intelephense",
		licenceKey = os.getenv("INTELEPHENSE_LICENSE_KEY") or nil,
		telemetry = {
			enabled = false,
		},
	},
})
