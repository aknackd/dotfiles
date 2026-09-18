-- Hyprland Lua configuration (0.55+)
-- https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------

-- Keep these explicit positions and scales: this is the configured multi-monitor layout.
-- Inactive laptop/desktop displays, retained for later re-enabling:
-- hl.monitor({ output = "eDP-1", mode = "2256x1504", position = "0x0", scale = 1.566667 })
-- hl.monitor({ output = "DP-3", mode = "2560x1440", position = "0x-1440", scale = 1.0 })
-- hl.monitor({ output = "DP-2", mode = "2560x1440", position = "0x-1440", scale = 1.0 })
hl.monitor({ output = "DP-1", mode = "3840x2160", position = "0x0", scale = 1.5 })
hl.monitor({ output = "HDMI-A-1", mode = "2560x1440", position = "2560x1", scale = 1, transform = 1 })

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = os.getenv("TERMINAL") or "ghostty"
local menu = "rofi -show drun"
local mainMod = "SUPER"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar --config $HOME/.config/waybar/config-hyprland.jsonc &")
	hl.exec_cmd("$HOME/Wallpaper/set-wallpaper.sh")
	hl.exec_cmd("swaync")
	hl.exec_cmd("wl-paste -t text --watch clipman store --primary --persist")
	hl.exec_cmd("vicinae server")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 10,
		gaps_out = 15,
		border_size = 1,
		col = {
			active_border = "rgba(ccccccff)",
			inactive_border = "rgba(aaaaaa33)",
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 0,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 0.99,
		shadow = {
			enabled = true,
			range = 8,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 6,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	cursor = {
		no_hardware_cursors = true,
	},

	animations = {
		enabled = false,
	},

	dwindle = {
		preserve_split = true,
		force_split = 2,
	},

	master = {
		new_status = "master",
	},

	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = true,
		background_color = 0x000000,
	},

	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = false,
		},
	},

	gestures = {
		workspace_swipe_distance = 300,
		workspace_swipe_touch = false,
		workspace_swipe_invert = true,
		workspace_swipe_touch_invert = false,
		workspace_swipe_min_speed_to_force = 30,
		workspace_swipe_cancel_ratio = 0.5,
		workspace_swipe_create_new = true,
		workspace_swipe_direction_lock = true,
		workspace_swipe_direction_lock_threshold = 10,
		workspace_swipe_forever = false,
		workspace_swipe_use_r = false,
		close_max_timeout = 1000,
	},
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = false, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = false, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = false, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = false, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = false, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = false, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = false, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = false, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = false, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = false, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = false, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = false, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = false, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = false, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = false, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = false, speed = 1.94, bezier = "almostLinear", style = "fade" })

hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("hyprctl dispatch togglefullscreen"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

hl.bind(mainMod .. " + CTRL + 4", hl.dsp.exec_cmd("$HOME/.local/bin/capture-screen --annotate"))
hl.bind(mainMod .. " + CTRL + SHIFT + 4", hl.dsp.exec_cmd("$HOME/.local/bin/capture-screen --clipboard"))
hl.bind(mainMod .. " + CTRL + SHIFT + L", hl.dsp.exec_cmd("swaylock -c 111111"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind("CTRL + Space", hl.dsp.exec_cmd("vicinae toggle"))

for _, key_direction in ipairs({
	{ "left", "left" },
	{ "right", "right" },
	{ "up", "up" },
	{ "down", "down" },
	{ "h", "left" },
	{ "l", "right" },
	{ "k", "up" },
	{ "j", "down" },
}) do
	hl.bind(mainMod .. " + " .. key_direction[1], hl.dsp.focus({ direction = key_direction[2] }))
	hl.bind(mainMod .. " + SHIFT + " .. key_direction[1], hl.dsp.window.move({ direction = key_direction[2] }))
end

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

local repeating = { locked = true, repeating = true }
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), repeating)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), repeating)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), repeating)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), repeating)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), repeating)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), repeating)

local locked = { locked = true }
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), locked)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), locked)

--------------------------
---- LAYERS AND RULES ----
--------------------------

hl.layer_rule({ name = "vicinae-blur", blur = true, ignore_alpha = 0, match = { namespace = "vicinae" } })
hl.layer_rule({ name = "vicinae-no-animation", no_anim = true, match = { namespace = "vicinae" } })

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	name = "ensure-steam-games-are-always-in-fullscreen",
	match = { class = "^(steam_app_.*)$" },
	rounding = 0,
	fullscreen = 1,
})
