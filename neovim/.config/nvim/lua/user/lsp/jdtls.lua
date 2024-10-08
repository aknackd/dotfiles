local util = require("lspconfig.util")
local env = require("user.utils").env

local root_files = {
	-- Single-module projects
	{ "build.xml", "pom.xml", "settings.gradle", "settings.gradle.kts" },
	-- Multi-module projects
	{ "build.gradle", "build.gradle.kts" },
	-- Other
	{ ".project" },
}

return {
	root_dir = function(fname)
		for _, patterns in ipairs(root_files) do
			local root = util.root_pattern(unpack(patterns))(fname)
			if root then
				return root
			end
		end
	end,
	settings = {
		java = {
			--
			-- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
			--
			home = env("JAVA_HOME", ""),
			autobuild = {
				enabled = false,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
			},
			eclipse = {
				downloadSources = true,
			},
			format = {
				enabled = false,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			maven = {
				downloadSources = true,
				updateSnapshots = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			saveActions = {
				organizeImports = true,
			},
			server = {
				launchMode = "lightweight",
			},
		},
		redhat = {
			telemetry = {
				enabled = false,
			},
		},
	},
}
