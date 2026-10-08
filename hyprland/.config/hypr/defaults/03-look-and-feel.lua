-- Shared appearance, input, layout, and animation settings.

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
