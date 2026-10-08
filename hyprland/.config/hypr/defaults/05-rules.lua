-- Shared layer and window rules.

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
