#!/usr/bin/env bash

# 1. Combineer Zoxide (frequentie/recentheid eerst) met FD (bestanden tot max diepte 4)
SELECTION=$( (
  zoxide query -l
  fd --hidden --max-depth 4 \
    --exclude .git \
    --exclude .cache \
    --exclude node_modules \
    --exclude .cargo \
    --exclude .local/share \
    . ~
) | sed "s|^$HOME/||" | awk '!a[$0]++' | fzf --prompt="📂 Yazi Opener: " \
  --height=100% \
  --reverse \
  --tiebreak=index \
  --color="pointer:#89dceb,prompt:#74c7ec,hl:#89dceb,hl+:#74c7ec" \
  --pointer="▶" \
  --border="rounded" \
  --margin="1" \
  --padding="1")

# 2. Stop als je op ESC drukt
[ -z "$SELECTION" ] && exit 0

# 3. Zorg voor een absoluut pad zonder trailing slash
if [[ "$SELECTION" = /* ]]; then
  FULL_PATH="$SELECTION"
else
  FULL_PATH="$HOME/$SELECTION"
fi
FULL_PATH="${FULL_PATH%/}"

# 4. Update Zoxide database en bepaal target
if [ -d "$FULL_PATH" ]; then
  zoxide add "$FULL_PATH"
  TARGET_DIR="$FULL_PATH"
  YAZI_ARG=""
else
  zoxide add "$(dirname "$FULL_PATH")"
  TARGET_DIR="$(dirname "$FULL_PATH")"
  YAZI_ARG="$FULL_PATH"
fi

WORKSPACE_NAME=$(basename "$TARGET_DIR")

# 5. Hyprland: Switch naar de workspace
hyprctl dispatch "hl.dsp.focus({ workspace = \"$WORKSPACE_NAME\" })"

# 6. Start Ghostty met Yazi
HYPR_CMD="ghostty --working-directory=$TARGET_DIR -e yazi $YAZI_ARG"
hyprctl dispatch "hl.dsp.exec_cmd(\"$HYPR_CMD\", { workspace = \"$WORKSPACE_NAME\" })"

