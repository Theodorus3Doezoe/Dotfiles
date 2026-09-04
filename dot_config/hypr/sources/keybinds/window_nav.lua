-- ============================================================================
-- Window Navigation & Management
-- ============================================================================
local mainMod = "SUPER"

-- ============================================================================
-- Window Modifiers
-- ============================================================================
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + S", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + X", hl.dsp.window.pin())

-- Focus Window
-- Colemak-DH hardware layer (F16..F19)
hl.bind("F16", hl.dsp.focus({ direction = "l" }))
hl.bind("F17", hl.dsp.focus({ direction = "d" }))
hl.bind("F18", hl.dsp.focus({ direction = "u" }))
hl.bind("F19", hl.dsp.focus({ direction = "r" }))

-- Laptop QWERTY (SUPER + HJKL)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))

-- ============================================================================
-- Move Window (SHIFT + F16..F19 & SUPER + SHIFT + HJKL)
-- ============================================================================
-- Colemak-DH hardware layer
hl.bind("SHIFT + F16", hl.dsp.window.move({ direction = "l" }))
hl.bind("SHIFT + F17", hl.dsp.window.move({ direction = "d" }))
hl.bind("SHIFT + F18", hl.dsp.window.move({ direction = "u" }))
hl.bind("SHIFT + F19", hl.dsp.window.move({ direction = "r" }))

-- Laptop QWERTY
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))

-- ============================================================================
-- Resize Mode (Submap)
-- ============================================================================
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
	-- Colemak-DH layer
	hl.bind("F16", hl.dsp.window.resize({ x = -15, y = 0, relative = true }), { repeating = true })
	hl.bind("F17", hl.dsp.window.resize({ x = 0, y = 15, relative = true }), { repeating = true })
	hl.bind("F18", hl.dsp.window.resize({ x = 0, y = -15, relative = true }), { repeating = true })
	hl.bind("F19", hl.dsp.window.resize({ x = 15, y = 0, relative = true }), { repeating = true })

	-- Laptop QWERTY (HJKL)
	hl.bind("H", hl.dsp.window.resize({ x = -15, y = 0, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = 15, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = -15, relative = true }), { repeating = true })
	hl.bind("L", hl.dsp.window.resize({ x = 15, y = 0, relative = true }), { repeating = true })

	hl.bind("Escape", hl.dsp.submap("reset"))
	hl.bind("Return", hl.dsp.submap("reset"))
end)
