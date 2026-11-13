if hl.plugin.hyprglass then
	local hg = hl.plugin.hyprglass

	hg.config({
		default_theme = "dark",
		default_preset = "clear",
		tint_color = 0x8899aa22,

		brightness = 0.9,
		dark = { brightness = 0.82 },
		light = { adaptive_boost = 0.5 },

		layers = { enabled = 1 },
	})

	-- Layer surfaces: each call whitelists the namespace and configures it
	hg.layer("waybar", { preset = "subtle", mask_threshold = 0.05 })
	hg.layer("swaync")
	hg.layer("quickshell:bezel", { preset = "ui", mask_threshold = 0.3 })
	hg.layer("debug-panel", { exclude = true })

	-- Presets
	hg.preset("clear", {
		glass_opacity = 0.8,
		blur_strength = 1.5,
		dark = { brightness = 0.7 },
		light = { brightness = 1.2 },
	})

	hg.preset("contrasted", {
		inherits = "high_contrast",
		contrast = 1.2,
		adaptive_dim = 1.5,
		dark = { tint_color = 0x02142aa9 },
	})

	hg.config({ layers = { enabled = true } })
	hg.layer("quickshell:bezel", { preset = "ui", mask_threshold = 0.3 })
	hl.window_rule({ match = { class = "com.mitchellh.ghostty" }, tag = "+hyprglass_preset_glass" })
	hl.window_rule({ match = { class = "zen" }, tag = "+hyprglass_preset_glass" })
end

if hl.plugin.hyprexpo then
	hl.config({
		plugin = {
			hyprexpo = {
				dynamic_grid = 1,
				skip_empty = 1,
				fill_gaps = 0,
				mru_sort = 0,
			},
		},
	})

	hl.define_submap("hyprexpo", function()
		hl.bind("left", function()
			hl.plugin.hyprexpo.kb_focus("left")
		end)
		hl.bind("right", function()
			hl.plugin.hyprexpo.kb_focus("right")
		end)
		hl.bind("up", function()
			hl.plugin.hyprexpo.kb_focus("up")
		end)
		hl.bind("down", function()
			hl.plugin.hyprexpo.kb_focus("down")
		end)

		hl.bind("return", function()
			hl.plugin.hyprexpo.kb_confirm()
		end)
		hl.bind("escape", function()
			hl.plugin.hyprexpo.expo("cancel")
		end)
		hl.bind("SUPER + G", function()
			hl.plugin.hyprexpo.expo("toggle")
		end)

		-- Блокируем ввод в приложение под обзором.
		hl.bind("mouse_up", function() end)
		hl.bind("mouse_down", function() end)
		hl.bind("mouse_left", function() end)
		hl.bind("mouse_right", function() end)
		hl.bind("catchall", function() end)
	end)
end
