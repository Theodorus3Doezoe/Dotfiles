-- ================-- ============================================================================
-- Monitor & Workspace Navigation (ALT + NEIO / F16-F19)
-- Geen SUPER toets: alles draait puur op ALT
-- ============================================================================
-- Beetje onnodig aangezien ik vaste workspaces per monitor heb

local monitorMod = "ALT"

-- ----------------------------------------------------------------------------
-- 1. Wrap-around helper functie voor Monitor Focus
-- ----------------------------------------------------------------------------
local function focus_monitor_wrap(dir)
	local monitors = hl.get_monitors()
	local active = hl.get_active_monitor()

	-- Als er maar 1 monitor is of data ontbreekt, val terug op standaard focus
	if not monitors or #monitors <= 1 or not active then
		hl.dispatch(hl.dsp.focus({ monitor = dir }))
		return
	end

	-- Horizontale navigatie (Links / Rechts)
	if dir == "l" or dir == "r" then
		table.sort(monitors, function(a, b)
			local ax = (a.position and a.position.x) or a.x or 0
			local bx = (b.position and b.position.x) or b.x or 0
			return ax < bx
		end)

		local idx = 1
		for i, m in ipairs(monitors) do
			if m.id == active.id then
				idx = i
				break
			end
		end

		local target_idx
		if dir == "l" then
			target_idx = (idx == 1) and #monitors or (idx - 1)
		else
			target_idx = (idx == #monitors) and 1 or (idx + 1)
		end

		hl.dispatch(hl.dsp.focus({ monitor = tostring(monitors[target_idx].id) }))

	-- Verticale navigatie (Omhoog / Omlaag)
	elseif dir == "u" or dir == "d" then
		table.sort(monitors, function(a, b)
			local ay = (a.position and a.position.y) or a.y or 0
			local by = (b.position and b.position.y) or b.y or 0
			return ay < by
		end)

		local idx = 1
		for i, m in ipairs(monitors) do
			if m.id == active.id then
				idx = i
				break
			end
		end

		local target_idx
		if dir == "u" then
			target_idx = (idx == 1) and #monitors or (idx - 1)
		else
			target_idx = (idx == #monitors) and 1 or (idx + 1)
		end

		hl.dispatch(hl.dsp.focus({ monitor = tostring(monitors[target_idx].id) }))
	else
		hl.dispatch(hl.dsp.focus({ monitor = dir }))
	end
end

-- ----------------------------------------------------------------------------
-- 2. Keymap definitie (Colemak-DH: F16 t/m F19, Laptop QWERTY: HJKL)
-- ----------------------------------------------------------------------------
local nav_keys = {
	{ f_key = "F16", key = "H", dir = "l", desc = "left" },
	{ f_key = "F17", key = "J", dir = "d", desc = "down" },
	{ f_key = "F18", key = "K", dir = "u", desc = "up" },
	{ f_key = "F19", key = "L", dir = "r", desc = "right" },
}

for _, item in ipairs(nav_keys) do
	local keys_to_bind = { item.f_key, item.key }

	for _, key in ipairs(keys_to_bind) do
		-- ## Monitor focus (ALT + F16..F19 / ALT + HJKL) -> met wrap around
		hl.bind(monitorMod .. " + " .. key, function()
			focus_monitor_wrap(item.dir)
		end, { description = "Focus monitor " .. item.desc .. " (wrap around)" })

		-- ## Window move to monitor (ALT + SHIFT + F16..F19 / ALT + SHIFT + HJKL)
		hl.bind(
			monitorMod .. " + SHIFT + " .. key,
			hl.dsp.window.move({ monitor = item.dir }),
			{ description = "Move window to monitor " .. item.desc }
		)

		-- ## Workspace move to monitor (ALT + CTRL + F16..F19 / ALT + CTRL + HJKL)
		hl.bind(
			monitorMod .. " + CTRL + " .. key,
			hl.dsp.workspace.move({ monitor = item.dir }),
			{ description = "Move workspace to monitor " .. item.desc }
		)
	end
end

-- ----------------------------------------------------------------------------
-- 3. Directe monitor numerieke binds (1 t/m 4) - eveneens zonder SUPER
-- ----------------------------------------------------------------------------
for m = 1, 4 do
	local monitor_str = tostring(m - 1)

	-- Focus direct op monitor (ALT + 1..4)
	hl.bind(
		monitorMod .. " + " .. m,
		hl.dsp.focus({ monitor = monitor_str }),
		{ description = "Focus on monitor " .. m }
	)

	-- Verplaats actieve workspace naar monitor (ALT + CTRL + 1..4)
	hl.bind(
		monitorMod .. " + CTRL + " .. m,
		hl.dsp.workspace.move({ monitor = monitor_str }),
		{ description = "Move workspace to monitor " .. m }
	)
end
