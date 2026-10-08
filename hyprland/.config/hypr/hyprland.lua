-- Hyprland Lua configuration (0.55+)
-- https://wiki.hypr.land/Configuring/Start/

local config_home = os.getenv("XDG_CONFIG_HOME")
local config_dir = config_home .. "/hypr"
local defaults_dir = config_dir .. "/defaults"

local function shell_quote(value)
	return "'" .. value:gsub("'", "'\\''") .. "'"
end

-- Section scripts use numeric prefixes so they load in a predictable order.
-- programs.lua is a data module loaded by keybindings.lua, not a section script.
local section_files = assert(
	io.popen("printf '%s\\n' " .. shell_quote(defaults_dir) .. "/[0-9][0-9]-*.lua", "r"),
	"Unable to list Hyprland default sections"
)
local sections = {}
for path in section_files:lines() do
	if path:match("/%d%d%-.+%.lua$") then
		table.insert(sections, path)
	end
end
section_files:close()

table.sort(sections)
assert(#sections > 0, "No numbered Hyprland default sections found in " .. defaults_dir)
for _, path in ipairs(sections) do
	dofile(path)
end

-- Load machine-specific settings after the shared defaults.

local profile = os.getenv("HYPRLAND_CONFIG_PROFILE") or "desktop"
local profiles = {
	desktop = config_dir .. "/profiles/desktop.lua",
	laptop = config_dir .. "/profiles/laptop.lua",
}

local profile_path = assert(profiles[profile], "Unknown profile: " .. profile)
dofile(profile_path)
