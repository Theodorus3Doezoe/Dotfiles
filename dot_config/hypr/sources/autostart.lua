local autostarts = {
	"waybar",
	"hypridle",
	"hyprpaper",
	"wl-paste --type text --watch cliphist store",
	"wl-paste --type image --watch cliphist store",
	"swayosd-server",
	"systemctl --user start hyprpolkitagent",
	"/usr/bin/gnome-keyring-daemon --start --components=secrets",
}

hl.on("hyprland.start", function()
	for _, cmd in ipairs(autostarts) do
		hl.exec_cmd(cmd)
	end
end)
