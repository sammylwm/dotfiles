local bind = require("conf.functions")

for i = 1, 9 do
	bind.add("super + " .. i, hl.dsp.focus({ workspace = i }))
	bind.add("super + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

bind.add("super + 0", hl.dsp.focus({ workspace = 10 }))
bind.add("super + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))
-- === Application Launchers ===
bind.add({ "super + T", "super + return" }, hl.dsp.exec_cmd("ghostty"))
bind.add("super + B", hl.dsp.exec_cmd("zen-browser"))
bind.add("super + R", hl.dsp.exec_cmd("hyprlauncher"))
bind.add("SUPER + E", hl.dsp.exec_cmd("ghostty -e yazi"), { description = "ghostty -e yazi" })

-- === Window Management ===
bind.add("super + Q", hl.dsp.window.close())
bind.add("super + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
bind.add("super + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
bind.add("super + SHIFT + T", hl.dsp.window.float({ action = "toggle" }))
bind.add("super + W", hl.dsp.group.toggle())

-- === Audio Controls ===
bind.add(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
bind.add(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
bind.add("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
bind.add("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
bind.add({ "XF86AudioPlay", "KP_Add" }, hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
bind.add({ "XF86AudioNext", "KP_Subtract" }, hl.dsp.exec_cmd("playerctl next"), { locked = true })
bind.add({ "XF86AudioPrev", "KP_Multiply" }, hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- === Brightness Controls ===
bind.add("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
bind.add("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

-- === Touchpad Gestures ===
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- === Move/resize windows with mainMod + LMB/RMB and dragging ===
bind.add("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window" })
bind.add("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

-- === Screenshots ===
bind.add("Print", hl.dsp.exec_cmd("hyprshot -m region"))
