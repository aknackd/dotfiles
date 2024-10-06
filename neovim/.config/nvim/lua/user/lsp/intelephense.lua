local utils = require("user.utils")

return {
	init_options = {
		globalStoragePath = utils.get_lsp_cache_dir() .. "/intelephense",
		telemetry = {
			enabled = false,
		},
	},
}
