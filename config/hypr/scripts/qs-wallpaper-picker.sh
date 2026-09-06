#!/usr/bin/env bash
# ==================================================
#  KoolDots (2026)
#  Project URL: https://github.com/LinuxBeginnings
#  License: GNU GPLv3
#  SPDX-License-Identifier: GPL-3.0-or-later
# ==================================================
# Toggle/launch qs-wallpaper-picker (Quickshell Wallpaper Picker)
# Default keybind: SUPER CTRL W

set -euo pipefail

QS_WALLPAPER_PICKER_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/quickshell/qs-wallpaper-picker"
PICTURES_DIR="$(xdg-user-dir PICTURES 2>/dev/null || echo "$HOME/Pictures")"
WALLPAPER_DIR="${QS_WALLPAPER_DIR:-$PICTURES_DIR/Wallpapers}"

# Ensure wallpaper dir exists so picker doesn't fail on first run
mkdir -p "$WALLPAPER_DIR"

# Export wallpaper directory for Quickshell settings
export QS_WALLPAPER_DIR="$WALLPAPER_DIR"

# 1) If the picker is already running, toggle/close it
if pgrep -u "$(id -u)" -f "quickshell.*qs-wallpaper-picker/Main.qml" >/dev/null 2>&1; then
  pkill -u "$(id -u)" -f "quickshell.*qs-wallpaper-picker/Main.qml" || true
  exit 0
fi

# 2) Launch via the vendored open_picker.sh script if present
if [ -x "$QS_WALLPAPER_PICKER_DIR/scripts/open_picker.sh" ]; then
  exec "$QS_WALLPAPER_PICKER_DIR/scripts/open_picker.sh"
fi

# 3) Fallback: direct quickshell launch
if command -v quickshell >/dev/null 2>&1 && [ -f "$QS_WALLPAPER_PICKER_DIR/Main.qml" ]; then
  exec quickshell -p "$QS_WALLPAPER_PICKER_DIR/Main.qml"
elif command -v qs >/dev/null 2>&1 && [ -f "$QS_WALLPAPER_PICKER_DIR/Main.qml" ]; then
  exec qs --log-rules "qt.qpa.wayland.textinput.warning=false" -p "$QS_WALLPAPER_PICKER_DIR/Main.qml"
else
  notify-send -u low "QS Wallpaper Picker" "Quickshell wallpaper picker is not installed or configured." 2>/dev/null || true
  exit 1
fi
