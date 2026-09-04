require("sources.animations")
require("sources.autostart")
require("sources.colors")
require("sources.decorations")
require("sources.defaults")
require("sources.env")
require("sources.input")
require("sources.monitors")
require("sources.keybinds")
require("sources.windowrules")

-- Added by hyprmoncfg: its generated monitor rules load last, so nothing before this can override the applied layout.
do local path = os.getenv("HOME") .. "/.config/hypr/hyprmoncfg-monitors.lua"; local file = io.open(path, "r"); if file then file:close(); dofile(path) end end
