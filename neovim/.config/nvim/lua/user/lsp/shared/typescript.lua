local util = require("lspconfig.util")

local M = {}
local version_cache = {}

local function project_root(fname)
	return util.root_pattern("package.json", ".git")(fname)
end

local function has_typescript_7(root)
	if version_cache[root] ~= nil then
		return version_cache[root]
	end

	local tsc = root .. "/node_modules/.bin/tsc"
	if vim.fn.executable(tsc) ~= 1 then
		version_cache[root] = false
		return false
	end

	local result = vim.system({ tsc, "--version" }, { text = true }):wait()
	local major = result.stdout and result.stdout:match("Version%s+(%d+)%.")
	version_cache[root] = major ~= nil and tonumber(major) >= 7
	return version_cache[root]
end

local function root_dir_for(bufnr, on_dir, predicate)
	local root = project_root(vim.api.nvim_buf_get_name(bufnr))
	if root and predicate(root) then
		on_dir(root)
	end
end

function M.native_root_dir(bufnr, on_dir)
	root_dir_for(bufnr, on_dir, function(root)
		return has_typescript_7(root)
	end)
end

function M.classic_root_dir(bufnr, on_dir)
	root_dir_for(bufnr, on_dir, function(root)
		return not has_typescript_7(root)
	end)
end

return M
