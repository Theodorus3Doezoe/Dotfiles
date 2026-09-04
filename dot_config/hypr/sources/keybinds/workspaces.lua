-- ============================================================================
-- Workspaces (1 - 10)
-- ============================================================================
local mainMod = "SUPER"

for i = 1, 10 do
	local num = (i == 10) and "0" or tostring(i)

	-- Standaard SUPER binds (voor alle workspaces 1 t/m 10 - laptop QWERTY & algemeen)
	hl.bind(mainMod .. " + " .. num, hl.dsp.focus({ workspace = tostring(i) }))
	hl.bind(mainMod .. " + SHIFT + " .. num, hl.dsp.window.move({ workspace = tostring(i) }))

	-- Extra F-toetsen voor Colemak-DH hardware layer (4, 5, 6 -> F13, F14, F15 zonder SUPER)
	if i >= 4 and i <= 6 then
		local fkey = "F" .. (i + 9) -- F13, F14, F15
		hl.bind(fkey, hl.dsp.focus({ workspace = tostring(i) }))
		hl.bind("SHIFT + " .. fkey, hl.dsp.window.move({ workspace = tostring(i) }))
	end
end
