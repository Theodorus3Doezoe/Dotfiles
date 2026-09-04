hl.window_rule({
	match = { class = "com.svend.yazi" },
	workspace = "special:S-yazi",
	float = true,
	size = "75% 75%",
	center = true,
	no_blur = true,
})

hl.window_rule({
	match = { class = "md.obsidian.Obsidian" },
	workspace = "special:S-obsidian",
	float = true,
	size = "70% 80%",
	center = true,
	no_blur = true,
})



hl.window_rule({
	match = { class = "com.svend.project-selector" },
	workspace = "special:S-selector",
	float = true,
	size = "45% 35%",
	center = true,
	opacity = "0.9",
	rounding = 10,
	border_color = { colors = { "rgba(89dcebfe)", "rgba(74c7ecff)" }, angle = 45 },
	no_blur = true,
})
