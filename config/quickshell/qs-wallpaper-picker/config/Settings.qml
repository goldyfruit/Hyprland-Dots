// ==================================================
//  KoolDots (2026)
//  Project URL: https://github.com/LinuxBeginnings
//  License: GNU GPLv3
//  SPDX-License-Identifier: GPL-3.0-or-later
// ==================================================
// KoolDots default settings for qs-wallpaper-picker (https://github.com/magetsu002/qs-wallpaper-picker).
// This file is tracked (unlike upstream's gitignored config/Settings.qml) so the picker
// works out-of-the-box after `bash copy.sh`/`bash upgrade.sh`.
//
// To customize without losing your changes on update, copy this file to a path outside
// this repo's sync target is not supported upstream; instead override via environment
// variables (see README.md) or edit this file directly under
// ~/.config/quickshell/qs-wallpaper-picker/config/Settings.qml.

import QtQuick
import Quickshell

QtObject {
    readonly property string homeDir: Quickshell.env("HOME")
    readonly property string configuredWallpaperDir:
        Quickshell.env("QS_WALLPAPER_DIR")
    readonly property string configuredCacheHome:
        Quickshell.env("XDG_CACHE_HOME")

    // KoolDots default: $HOME/Pictures/Wallpapers (override with QS_WALLPAPER_DIR)
    property string wallpaperDir:
        configuredWallpaperDir !== ""
            ? configuredWallpaperDir
            : homeDir + "/Pictures/Wallpapers"
    readonly property string cacheHome:
        configuredCacheHome !== ""
            ? configuredCacheHome
            : homeDir + "/.cache"
    readonly property string cacheDir:
        cacheHome + "/wallpaper_picker"
    readonly property string thumbDir:
        cacheDir + "/thumbs"

    property bool uiAnimationsEnabled: true
    property real uiAnimationScale: 1.0

    property string wallpaperTransitionType: "random"
    property real wallpaperTransitionDuration: 0.6
    property int wallpaperTransitionFps: 60

    property int closeDelayMs: 120
    property int scrollThrottleMs: 150
    property int filterAnimationMs: 800
    property int itemAnimationMs: 500

    property bool enableDynamicColors: false
    property bool enableMatugen: false
    property bool enableHyprReload: false
    property bool enableWaybarReload: false
    property bool enableKittyReload: false
    property bool enableCavaReload: false
    property bool enableSwayncReload: false
    property bool enableSwayosdReload: false

    property string hyprColorsPath:
        homeDir + "/.config/hypr/colors.conf"
    property string waybarColorsPath:
        homeDir + "/.config/waybar/colors.css"
    property string waybarLaunchPath:
        homeDir + "/.config/waybar/launch.sh"
    property string kittySignalProcess:
        ".kitty-wrapped"

    property string extraReloadCommand: ""
}
