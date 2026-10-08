-- Positions use scaled logical pixels. The 4K displays at scale 1.5 are
-- 2560x1440 logical; rotated portrait displays are 1440x2560 logical.
-- Rules for disconnected outputs are ignored, so both host layouts can coexist.

-- Laptop: DP-3 above eDP-1, with portrait DP-2 to the right of DP-3.
hl.monitor({ output = "eDP-1", mode = "2256x1504", position = "0x0", scale = 1.566667 })
hl.monitor({ output = "DP-3", mode = "3840x2160", position = "0x-1440", scale = 1.5 })
hl.monitor({ output = "DP-2", mode = "3840x2160", position = "2560x-1440", scale = 1.5, transform = 1 })

-- Top monitor should always have the first workspace, then the monitor on the right, then finally the laptop
hl.workspace_rule({ workspace = "3", monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-2", default = true })
hl.workspace_rule({ workspace = "1", monitor = "DP-3", default = true })
