local M = {}

-- Creates the cache directory to use for language servers if it doesn't exist
function M.create_lsp_cache_dir()
	local dir = M.get_lsp_cache_dir()

	if not M.is_dir(dir) then
		vim.fn.mkdir(dir, 'p')
	end
end

-- Returns the cache directory to use for language servers
-- @return string Cache directory path
function M.get_lsp_cache_dir()
	return vim.fn.stdpath('cache')..'/lsp'
end

-- Checks if a directory exists
-- @param path string Directory path
-- @return boolean
function M.dir_exists(path)
	local ok, _, code = os.rename(path, path)

	-- Permission was denied but the directory exists
	if not ok and code == 13 then
		return true
	end

	return ok
end

-- Checks if a file cists
-- @return boolean True if the file exists, otherwise false
function M.file_exists(path)
	local f = io.open(path, 'r')
	return f ~= nil and io.close(f)
end

-- Finds an executable in PATH
-- @param exe string Executable name
-- @return string Path to executable if found, otherwise nil
function M.find_in_path(exe)
	local sep = M.get_directory_separator()

	local delimiter = ":"
	if M.is_windows() then delimiter = ";" end

	-- Loop through directories in PATH and return the first
	-- executable file with the matching name

	local dirs = M.split(delimiter, os.getenv("PATH"))

	for _, dir in pairs(dirs) do
		local path = dir .. sep .. exe
		if M.file_exists(path) and vim.fn.executable(path) == 1 then
			return path
		end
	end

	return nil
end

-- Gets the specified colorscheme from NVIM_COLORSCHEME
-- @return string Colorscheme name
function M.get_colorscheme()
	return os.getenv('NVIM_COLORSCHEME') or 'default'
end

-- Returns the OS directory separator
-- @return string
function M.get_directory_separator()
	return package.config:sub(1, 1)
end

-- Returns LSP servers that Mason will always install by default
-- @return table
function M.get_lsp_servers()
	local servers = { 'lua_ls' }
	M.mergetable(servers, M.split(',', os.getenv('NVIM_LSP_SERVERS') or ''))

	return M.remove_duplicates(servers)
end

-- Returns whether or not a feature is enabled via an environment variable
-- named "NVIM_FEATURE_{feature}" is set and has a truthy value.
-- @param feature Feature
-- @return boolean
function M.has_feature(feature)
	local value = os.getenv("NVIM_FEATURE_"..string.upper(feature)) or ''
	return string.match(value, 'y|Y|true|1')
end

-- Returns whether or not a table has a specified key
-- @param t table Table
-- @param s string Key
-- @return boolean
function M.has_key(t, s)
	return t[s] ~= nil
end

-- Returns whether or not a path is a directory
-- @param path string Filesystem path
-- @return boolean
function M.is_dir(path)
	return M.dir_exists(path..'/')
end

-- Returns whether or not we're currently running on *nix
-- @return boolean
function M.is_unix()
	return M.get_directory_separator() == "/"
end

-- Returns whether or not we're currently running on Windows
-- @return boolean
function M.is_windows()
	return M.get_directory_separator() == "\\"
end

-- Merges two tables
-- @param dest table Destination
-- @param src table Source
function M.mergetable(dest, src)
	for k, v in pairs(src) do dest[k] = v end
end

-- Removes duplicate values from a table
-- @param input table Input
-- @return table
function M.remove_duplicates(input)
	local found = {}
	local uniques = {}

	for _, value in ipairs(input) do
		if (not found[value]) then
			uniques[#uniques+1] = value
			found[value] = true
		end
	end

	return uniques
end

-- Split a string by a delimiter
-- @param delimiter string Delimiter
-- @param input string String input
-- @return table
function M.split(delimiter, input)
	local fields = {}

    delimiter = delimiter or ' '
    local pattern = string.format("([^%s]+)", delimiter)
    pattern = string.gsub(input, pattern, function(c) fields[#fields + 1] = c end)

    return fields
end

-- @param plugin_name string Name of packer plugins
function M.use_colorscheme_plugin(plugin_name)
	return {
		plugin_name,
		config = function()
			-- Get the specified colorscheme, which needs to be in the format "{plugin}:{colorscheme}"
			-- Example: rebelot/kanagawa.nvim:kanagawa
			local colorscheme = M.get_colorscheme()
			-- Grab the actual colorscheme name and if it's a part of this
			-- plugin, then load the color plugin's module which contains
			-- settings and other configuration specific to that colorscheme,
			-- then call the config function on that module if it exists
			local parts = M.split(':', colorscheme)
			if #parts == 2  and parts[1] == plugin_name then
				local module = 'user.plugins.colors.'..parts[2]
				if module['config'] ~= nil then require(module).config() end
			end
		end,
	}
end

return M
