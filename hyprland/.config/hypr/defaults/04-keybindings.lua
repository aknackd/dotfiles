-- Shared keyboard and mouse bindings.

local programs = dofile(os.getenv("XDG_CONFIG_HOME") .. "/hypr/defaults/programs.lua")
local main_mod = programs.main_mod

hl.bind(main_mod .. " + Return", hl.dsp.exec_cmd(programs.terminal))
hl.bind(main_mod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(main_mod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(main_mod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + SHIFT + F", hl.dsp.exec_cmd("hyprctl dispatch togglefullscreen"))
hl.bind(main_mod .. " + D", hl.dsp.exec_cmd(programs.menu))
hl.bind(main_mod .. " + P", hl.dsp.window.pseudo())

hl.bind(main_mod .. " + CTRL + 4", hl.dsp.exec_cmd("$HOME/.local/bin/capture-screen --annotate"))
hl.bind(main_mod .. " + CTRL + SHIFT + 4", hl.dsp.exec_cmd("$HOME/.local/bin/capture-screen --clipboard"))
hl.bind(main_mod .. " + CTRL + SHIFT + L", hl.dsp.exec_cmd("swaylock -c 111111"))
hl.bind(main_mod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

hl.bind("CTRL + Space", hl.dsp.exec_cmd("vicinae toggle"))

-- Focus windows
hl.bind(main_mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(main_mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(main_mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(main_mod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(main_mod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(main_mod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(main_mod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(main_mod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(main_mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(main_mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(main_mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(main_mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(main_mod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(main_mod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(main_mod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(main_mod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

hl.bind(main_mod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(main_mod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(main_mod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(main_mod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(main_mod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(main_mod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(main_mod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(main_mod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(main_mod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(main_mod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(main_mod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(main_mod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(main_mod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(main_mod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(main_mod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(main_mod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(main_mod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(main_mod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(main_mod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(main_mod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

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
