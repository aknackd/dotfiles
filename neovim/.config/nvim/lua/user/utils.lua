local M = {}

---Creates the cache directory to use for language servers if it doesn't exist.
function M.create_lsp_cache_dir()
	local dir = M.get_lsp_cache_dir()

	if not M.is_dir(dir) then
		vim.fn.mkdir(dir, "p")
	end
end

---Returns the background, which can be set via the `NVIM_BACKGROUND`
---environment variable.
---@return string # \"light\" or \"dark"
function M.get_background()
	local default = "dark"
	local value = M.env("NVIM_BACKGROUND", default)

	if value:len() == 0 or value ~= "light" or value ~= "dark" then
		return default
	end

	return value
end

---Returns the cache directory to use for language servers.
---@return string # Cache directory path
function M.get_lsp_cache_dir()
	return vim.fn.stdpath("cache") .. "/lsp"
end

---Checks if a directory exists.
---@param path string Directory path
---@return boolean
function M.dir_exists(path)
	local ok, _, code = os.rename(path, path)

	-- Permission was denied but the directory exists
	if not ok and code == 13 then
		return true
	end

	return ok
end

---Gets the value of an environment variable.
---@param env_var string Environment variable
---@param default string Default value if environment variable is not set **or** is an empty string
---@return string
function M.env(env_var, default)
	local value = os.getenv(env_var) or default

	-- If the environment variable was set but is an empty string, return the default
	if value:len() == 0 and default:len() > 0 then
		return default
	end

	return value
end

---Checks if a file exists.
---@return boolean
function M.file_exists(path)
	local f = io.open(path, "r")
	if f ~= nil and f:close() then
		return true
	end
	return false
end

---Finds an executable in PATH.
---@param exe string Executable name
---@return string|nil
function M.find_in_path(exe)
	local sep = M.get_directory_separator()

	local delimiter = ":"
	if M.is_windows() then
		delimiter = ";"
	end

	-- Loop through directories in PATH and return the first
	-- executable file with the matching name

	local dirs = M.split(delimiter, M.env("PATH", ""))

	for _, dir in pairs(dirs) do
		local path = dir .. sep .. exe
		if M.file_exists(path) and vim.fn.executable(path) == 1 then
			return path
		end
	end

	return nil
end

---Gets the specified colorscheme from the `NVIM_COLORSCHEME` environment
---variable.
---@return string
function M.get_colorscheme()
	return M.env("NVIM_COLORSCHEME", "hybrid_reverse")
end

---Returns the OS directory separator.
---@return string
function M.get_directory_separator()
	return package.config:sub(1, 1)
end

---Returns LSP servers that Mason will always install by default. LSP servers
---are specified by a comma separated string defined in the `NVIM_LSP_SERVERS`
---environment variable.
---@return table<string>
function M.get_lsp_servers()
	local servers = { "lua_ls" }
	M.mergetable(servers, M.split(",", M.env("NVIM_LSP_SERVERS", "")))

	return M.remove_duplicates(servers)
end

---Returns whether or not a feature is enabled via an environment variable
---named `NVIM_FEATURE_{feature}` is set and has a truthy value.
---@param feature string Feature name
---@return boolean
function M.has_feature(feature)
	local value = M.env("NVIM_FEATURE_" .. string.upper(feature), "")
	return string.match(value, "y|Y|true|1")
end

---Returns whether or not a table has a specified key.
---@param t table Table
---@param s string Key
---@return boolean
function M.has_key(t, s)
	return t[s] ~= nil
end

---Returns whether or not a path is a directory.
---@param path string Filesystem path
---@return boolean
function M.is_dir(path)
	return M.dir_exists(path .. "/")
end

---Returns whether or not we're currently running on *nix.
---@return boolean
function M.is_unix()
	return M.get_directory_separator() == "/"
end

---Returns whether or not we're currently running on windows.
---@return boolean
function M.is_windows()
	return M.get_directory_separator() == "\\"
end

---Merges two tables.
---@param dest table Destination
---@param src table Source
function M.mergetable(dest, src)
	for k, v in pairs(src) do
		dest[k] = v
	end
end

---Removes duplicate values from a table.
---@param input table Input
---@return table
function M.remove_duplicates(input)
	local found = {}
	local uniques = {}

	for _, value in ipairs(input) do
		if not found[value] then
			uniques[#uniques + 1] = value
			found[value] = true
		end
	end

	return uniques
end

---Split a string by a delimiter.
---@param delimiter string Delimiter
---@param input string String input
---@return table
function M.split(delimiter, input)
	local fields = {}

	delimiter = delimiter or " "
	local pattern = string.format("([^%s]+)", delimiter)
	pattern = string.gsub(input, pattern, function(c)
		fields[#fields + 1] = c
	end)

	return fields
end

return M
