hl.config({
	animations = {
		enabled = true,

		-- Je custom curves (beziers)
		bezier = {
			"easeOutQuint, 0.23, 1, 0.32, 1",
			"easeInOutCubic, 0.65, 0.05, 0.36, 1",
			"linear, 0, 0, 1, 1",
			"almostLinear, 0.5, 0.5, 0.75, 1",
			"quick, 0.15, 0, 0.1, 1",
			"overshot, 0.05, 0.9, 0.1, 1.05",
		},

		-- Al je specifieke animaties (versneld voor meer snappy gevoel)
		animation = {
			"global, 1, 3, default",
			"border, 1, 3, easeOutQuint",
			"windows, 1, 3, easeOutQuint",
			"windowsIn, 1, 3, easeOutQuint, popin 87%",
			"windowsOut, 1, 3, easeOutQuint, popin 87%",
			"fadeIn, 1, 3, almostLinear",
			"fadeOut, 1, 3, almostLinear",
			"fade, 1, 3, quick",
			"layers, 1, 3, easeOutQuint",
			"layersIn, 1, 3, easeOutQuint, fade",
			"layersOut, 1, 3, linear, fade",
			"fadeLayersIn, 1, 3, almostLinear",
			"fadeLayersOut, 1, 3, almostLinear",
			"workspaces, 1, 3, easeOutQuint, slide",
			"workspacesIn, 1, 3, easeOutQuint, slide",
			"workspacesOut, 1, 3, easeOutQuint, slide",
			"zoomFactor, 1, 3, quick",
			-- Iets trager (5) en met easeOutQuint voor een minder schokvrije vertraging
			"specialWorkspace, 1, 5, easeOutQuint, slidevert",
		},
	},
})
