local M = {}

-- Gets the specified colorscheme from NVIM_COLORSCHEME
-- @return string Colorscheme name
function M.get_colorscheme()
	return os.getenv('NVIM_COLORSCHEME') or 'default'
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
