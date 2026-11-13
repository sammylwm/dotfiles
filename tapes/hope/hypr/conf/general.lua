hl.config({
	input = {
		kb_layout = "us,ru",
		kb_options = "grp:alt_shift_toggle",
		numlock_by_default = true,
		follow_mouse = 1,
		touchpad = {
			tap_to_click = true,
			natural_scroll = true,
		},
	},
	general = {
		gaps_in = 2,
		gaps_out = 10,
		border_size = 0,
		layout = "dwindle",
		-- layout = "lua:columns",
	},
	decoration = {
		rounding = 10,
		active_opacity = 0.85,
		inactive_opacity = 0.7,
		fullscreen_opacity = 1.0,
		blur = {
			enabled = true,
			size = 3,
			passes = 5,
			ignore_opacity = true,
			xray = false,
			popups = true,
		},
		shadow = {
			enabled = true,
			range = 15,
			render_power = 4,
			color = "rgba(00000080)",
		},
	},
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		focus_on_activate = false,
	},
	dwindle = {
		preserve_split = true,
	},
	master = {
		mfact = 0.5,
	},
})
