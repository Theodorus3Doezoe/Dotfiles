-- ============================================================================
-- App & Screenshot Shortcuts
-- ============================================================================
local mainMod = "SUPER"
local menu = "pkill -x rofi || rofi -show drun"
local browser = "brave-origin-nightly"

-- ============================================================================
-- App Shortcuts
-- ============================================================================
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("ghostty --working-directory=/home/sven"))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd("/home/sven/.config/hypr/scripts/ghostty_cwd.sh"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("~/.config/rofi/powermenu.sh"))
hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- ============================================================================
-- Screenshot Shortcuts
-- ============================================================================
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))
hl.bind("CONTROL + Print", hl.dsp.exec_cmd("grim - | wl-copy"))
