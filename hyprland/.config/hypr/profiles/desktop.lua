-- Positions use scaled logical pixels. The 4K displays at scale 1.5 are
-- 2560x1440 logical; rotated portrait displays are 1440x2560 logical.
-- Rules for disconnected outputs are ignored, so both host layouts can coexist.

-- Desktop: landscape top monitor, portrait monitor to its right.
hl.monitor({ output = "DP-1", mode = "3840x2160", position = "0x0", scale = 1.5 })
hl.monitor({ output = "HDMI-A-1", mode = "2560x1440", position = "2560x0", scale = 1, transform = 1 })
