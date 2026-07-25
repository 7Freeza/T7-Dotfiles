# T7 Hyprland + Noctalia — keybinds

Source of truth: [`config/hypr/hyprland.lua`](../config/hypr/hyprland.lua)

`mainMod` = **Super**

## Noctalia shell

| Key | Action |
|-----|--------|
| `Super + Space` | Launcher |
| `Super + Alt + L` | Lock screen |
| `Super + Shift + Q` | Session menu |
| `Super + Shift + I` | Wallpaper selector |
| `Super + Shift + W` | Next wallpaper (recolors rice) |

## Apps

| Key | Action |
|-----|--------|
| `Super + Q` | Kitty |
| `Super + W` | Zen Browser |
| `Super + E` | Nautilus |

## Windows

| Key | Action |
|-----|--------|
| `Super + C` | Close |
| `Super + F` / `F11` | Fullscreen |
| `Super + V` | Toggle floating |
| `Super + T` | Toggle group |
| `Super + B` | Togglesplit (dwindle) |
| `Super + P` | Pseudo-tile |

## Focus / move

| Key | Action |
|-----|--------|
| `Super + ←↑↓→` | Focus direction |
| `Super + K / L / J / M` | Focus (60% layout: left/right/up/down) |
| `Super + Shift + ←↑↓→` | Move window |
| `Super + Shift + K/L/J/M` | Move window (60%) |
| `Super + mouse LMB` | Drag window |
| `Super + mouse RMB` | Resize window |

## Monitors

| Key | Action |
|-----|--------|
| `Super + Alt + ←↑↓→` | Focus monitor |
| `Super + Shift + Ctrl + ←↑↓→` | Move window to monitor |

## Workspaces

| Key | Action |
|-----|--------|
| `Super + 1…9` | Focus workspace |
| `Super + Shift + 1…9` | Move window to workspace |
| `Super + Tab` | Previous workspace |
| `Super + scroll` | Next/prev workspace |
| `Super + Shift/Ctrl + scroll` | Move window across workspaces |

## Resize (symbol-based, works on latam + K630)

| Key | Action |
|-----|--------|
| `Super + ñ` | Shrink width |
| `Super + {` | Grow width |
| `Super + Shift + ñ` | Shrink height |
| `Super + Shift + {` | Grow height |

## Media / brightness → Noctalia IPC

| Key | Action |
|-----|--------|
| `XF86AudioRaise/Lower` | Volume |
| `XF86AudioMute` / `MicMute` | Mute output / input |
| `XF86AudioPlay/Pause/Next/Prev` | Media |
| `XF86MonBrightnessUp/Down` | Brightness |

## Screenshots (`t7-screenshot`)

| Key | Action |
|-----|--------|
| `Ctrl + Shift + 1` | Region |
| `Ctrl + Shift + 2` | Fullscreen |
| `Ctrl + Shift + 3` | Active window |
| `Print` | Fullscreen |

## System

| Key | Action |
|-----|--------|
| `Super + Shift + P` | DPMS off |
| `Ctrl + Alt + Delete` / `Super + Shift + E` | Exit Hyprland |
| Lid switch | `t7-display auto` (clamshell / HDMI) |

## Keyboard policy

| Device | Layout |
|--------|--------|
| Laptop (`at-translated-set-2-keyboard`) | `latam` |
| Redragon K630 (`evision-rgb-keyboard*`) | custom XKB `t7-k630-v4-full.xkb` (US + ñ) |
| Virtual noise (GSR UI, AVRCP, video-bus) | **disabled** |

Binds use `resolve_binds_by_sym = true` so Super+ñ works on both boards.
