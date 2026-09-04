-- ============================================================================
-- Scratchpads (Special Workspaces)
-- ============================================================================
local mainMod = "SUPER"

local scratchpads = {
	["com.svend.yazi"] = "S-yazi",
	["com.svend.project-selector"] = "S-selector",
	["md.obsidian.Obsidian"] = "S-obsidian",
}

local function toggle_sp(class, cmd, sp_name)
	-- Check if the special workspace is currently active on ANY monitor
	local scratchpad_monitor = nil
	for _, monitor in ipairs(hl.get_monitors()) do
		local sp = hl.get_active_special_workspace(monitor)
		if sp and sp.name == "special:" .. sp_name then
			scratchpad_monitor = monitor
			break
		end
	end

	if scratchpad_monitor then
		-- It is active, so we want to close/hide it
		local current_monitor = hl.get_active_monitor()
		local active_window = hl.get_active_window()

		if scratchpad_monitor.id ~= current_monitor.id then
			-- Focus the monitor where the scratchpad is open
			hl.dispatch(hl.dsp.focus({ monitor = scratchpad_monitor.name }))
			-- Toggle it off on that monitor
			hl.dispatch(hl.dsp.workspace.toggle_special(sp_name))
			-- Focus back to the original active window or monitor
			if active_window then
				hl.dispatch(hl.dsp.focus({ window = "address:" .. active_window.address }))
			else
				hl.dispatch(hl.dsp.focus({ monitor = current_monitor.name }))
			end
		else
			hl.dispatch(hl.dsp.workspace.toggle_special(sp_name))
		end
	else
		-- It is NOT active anywhere, so we want to open it on the currently focused monitor
		local windows = hl.get_windows({ class = class })
		if #windows == 0 then
			hl.exec_cmd(cmd)
		end

		-- Toggle it on on the currently focused monitor
		hl.dispatch(hl.dsp.workspace.toggle_special(sp_name))
		if #windows > 0 then
			hl.dispatch(hl.dsp.focus({ window = "address:" .. windows[1].address }))
			hl.dispatch(hl.dsp.window.center())
			hl.dispatch(hl.dsp.cursor.move_to_corner({ corner = 1 }))
		else
			hl.dispatch(hl.dsp.focus({ workspace = "special:" .. sp_name }))
		end
	end
end

-- Auto-focus and warp cursor to scratchpads when opened
hl.on("window.open", function(window)
	if scratchpads[window.class] then
		hl.dispatch(hl.dsp.focus({ window = "address:" .. window.address }))
		hl.dispatch(hl.dsp.window.center())
		hl.dispatch(hl.dsp.cursor.move_to_corner({ corner = 1 }))
	end
end)

-- Auto-hide on focus loss (Spotless behavior)
hl.on("window.active", function(window)
	-- Hide cursor when Yazi or Project Selector is active
	if window and (window.class == "com.svend.yazi" or window.class == "com.svend.project-selector") then
		hl.config({ cursor = { inactive_timeout = 0.001 } })
	else
		hl.config({ cursor = { inactive_timeout = 0 } })
	end

	for _, monitor in ipairs(hl.get_monitors()) do
		local sp = hl.get_active_special_workspace(monitor)
		if sp then
			local sp_full_name = sp.name
			local sp_short_name = sp_full_name:gsub("special:", "")

			local is_ours = false
			for _, name in pairs(scratchpads) do
				if name == sp_short_name then
					is_ours = true
					break
				end
			end

			if is_ours then
				if not window or not window.workspace or window.workspace.name ~= sp_full_name then
					local current_monitor = hl.get_active_monitor()
					if monitor.id ~= current_monitor.id then
						-- Focus the monitor where the scratchpad is open
						hl.dispatch(hl.dsp.focus({ monitor = monitor.name }))
						-- Toggle it off on that monitor
						hl.dispatch(hl.dsp.workspace.toggle_special(sp_short_name))
						-- Return focus to the original active window/monitor
						if window then
							hl.dispatch(hl.dsp.focus({ window = "address:" .. window.address }))
						else
							hl.dispatch(hl.dsp.focus({ monitor = current_monitor.name }))
						end
					else
						hl.dispatch(hl.dsp.workspace.toggle_special(sp_short_name))
					end
				end
			end
		end
	end
end)

-- Scratchpad Shortcuts
hl.bind(mainMod .. " + Y", function()
	toggle_sp(
		"com.svend.yazi",
		"ghostty --class=com.svend.yazi -e /home/sven/.config/hypr/scripts/yazi_selector.sh",
		"S-yazi"
	)
end)

hl.bind(mainMod .. " + P", function()
	toggle_sp(
		"com.svend.project-selector",
		"ghostty --class=com.svend.project-selector -e /home/sven/.config/hypr/scripts/project_selector.sh",
		"S-selector"
	)
end)

hl.bind(mainMod .. " + N", function()
	toggle_sp("md.obsidian.Obsidian", "obsidian", "S-obsidian")
end)
