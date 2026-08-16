hl.curve("snappy", { type = "bezier", points = {
	{ 0.1, 0.9 },
	{ 0.2, 1.0 },
} })

hl.animation({
	leaf = "windowsIn",
	enabled = true,
	speed = 2.8,
	bezier = "snappy",
	style = "popin 92%",
})

hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 2,
	bezier = "default",
	style = "popin 92%",
})

hl.animation({
	leaf = "windowsMove",
	enabled = true,
	speed = 2.5,
	bezier = "snappy",
})

hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 3.5,
	bezier = "snappy",
	style = "slidefade 18%",
})

hl.animation({
	leaf = "specialWorkspace",
	enabled = true,
	speed = 3.5,
	bezier = "snappy",
	style = "slidefadevert 25%",
})

hl.animation({
	leaf = "layers",
	enabled = true,
	speed = 2,
	bezier = "default",
	style = "fade",
})

hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 2,
	bezier = "default",
})

hl.animation({
	leaf = "border",
	enabled = true,
	speed = 2,
	bezier = "default",
})
