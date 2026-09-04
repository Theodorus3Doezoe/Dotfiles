# Summary of hyprland binds and logic

Mainmod = Super

## Window focus

- Colemak-DH: F16..F19 (laag zonder Super)
- Laptop QWERTY: Super + hjkl

## Window move

- Colemak-DH: Shift + F16..F19
- Laptop QWERTY: Super + Shift + hjkl

## Workspace focus

- Colemak-DH: 1..3, 7..10 (Super + num) & 4..6 (F13..F15 direct)
- Laptop QWERTY: Super + 1..10

## Window move to workspace

- Colemak-DH: Super + Shift + 1..3, 7..10 & Shift + F13..F15
- Laptop QWERTY: Super + Shift + 1..10

## Workspace move to Workspace

bind = $mainMod CTRL, 1, exec, hyprctl -j clients | jq -r '.[] | select(.workspace.id == '$(hyprctl activeworkspace -j | jq .id)') | .address' | xargs -I{} hyprctl dispatch movetoworkspacesilent 1,address:{}

- ctrl + num

## Monitor focus

wrap arround script

- Colemak-DH: Alt + F16..F19
- Laptop QWERTY: Alt + hjkl

## Window move to monitor

- Colemak-DH: Alt + Shift + F16..F19
- Laptop QWERTY: Alt + Shift + hjkl

## Workspace move to monitor

- Colemak-DH: Alt + Ctrl + F16..F19
- Laptop QWERTY: Alt + Ctrl + hjkl

## window binds

- kill Window
- float window
- toggle split
- fullscreen
- resize
- pin window

## shortcuts

- terminal
- terminal same directory
- wofi
- wofi clipboard
- powermenu
- hyprlock
- Browser
- Reload
- printsceen , shift , control

## scratchpads

- Yazi
- Project selector in nvim
- Obsidian
