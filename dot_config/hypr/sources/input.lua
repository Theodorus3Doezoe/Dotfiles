hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		-- Voeg dit toe aan je input configuratie block
		kb_options = "fkeys:basic_13-24",
		-- Je eventuele andere input instellingen...

		follow_mouse = 1,
		mouse_refocus = false,
		float_switch_override_focus = 0,
		sensitivity = 0,
		accel_profile = "flat", -- 0 betekent geen aanpassing
		force_no_accel = false,

		-- Geneste tabel voor je touchpad
		touchpad = {
			natural_scroll = true,
		},
	},
	cursor = {
		-- Voorkomt dat de cursor 'vastplakt' op de rand tussen verschillende schaalfactoren
		no_warps = false,

		-- Forceert directe overgang op de pixelgrens (0 betekent geen extra padding/drempel)
		hotspot_padding = 0,

		-- Zorgt dat hardware rendering aan blijft voor minimale latency
		no_hardware_cursors = false,
	},
	xwayland = {
		force_zero_scaling = true,
	},
})
