-- Start shared desktop services with the session.

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar --config $HOME/.config/waybar/config-hyprland.jsonc &")
	hl.exec_cmd("$HOME/Wallpaper/set-wallpaper.sh")
	hl.exec_cmd("swaync")
	hl.exec_cmd("wl-paste -t text --watch clipman store --primary --persist")
	hl.exec_cmd("vicinae server")
end)
