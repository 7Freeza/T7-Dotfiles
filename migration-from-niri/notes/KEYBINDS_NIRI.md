# Niri keybinds → translate to Hyprland later

Source: `~/.config/niri/cfg/keybinds.kdl`  
Mod = Super

| Niri bind | Overlay title | Action |
|-----------|---------------|--------|

// ────────────── Keybindings ──────────────

// ─── noctalia-shell ───
| `Mod+Shift+ESCAPE` | — | `show-hotkey-overlay;` |
| `Mod+Space` | Launcher | `spawn-sh "qs -c noctalia-shell ipc call launcher toggle";` |
| `Mod+ALT+L` | Lock screen | `spawn-sh "qs -c noctalia-shell ipc call lockScreen lock";` |
| `Mod+Shift+Q` | Session menu | `spawn-sh "qs -c noctalia-shell ipc call sessionMenu toggle";` |
| `XF86AudioRaiseVolume` | — | `spawn-sh "qs -c noctalia-shell ipc call volume increase";` |
| `XF86AudioLowerVolume` | — | `spawn-sh "qs -c noctalia-shell ipc call volume decrease";` |
| `XF86AudioMute` | — | `spawn-sh "qs -c noctalia-shell ipc call volume muteOutput";` |
| `XF86AudioMicMute` | — | `spawn-sh "qs -c noctalia-shell ipc call volume muteInput";` |
| `XF86AudioNext` | — | `spawn-sh "qs -c noctalia-shell ipc call media next";` |
| `XF86AudioPrev` | — | `spawn-sh "qs -c noctalia-shell ipc call media previous";` |
| `XF86AudioPlay` | — | `spawn-sh "qs -c noctalia-shell ipc call media playPause";` |
| `XF86AudioPause` | — | `spawn-sh "qs -c noctalia-shell ipc call media playPause";` |
| `XF86MonBrightnessUp` | — | `spawn-sh "qs -c noctalia-shell ipc call brightness increase";` |
| `XF86MonBrightnessDown` | — | `spawn-sh "qs -c noctalia-shell ipc call brightness decrease";` |

// ─── Applications ───
| `Mod+Q` | Terminal | `spawn "kitty";` |
| `Mod+W` | Browser | `spawn-sh "$HOME/.local/bin/zen-browser";` |
| `Mod+E` | File manager | `spawn "nautilus";` |

// ─── Ventanas: foco y movimiento ───
| `Mod+C` | Close window | `close-window;` |
| `Mod+Left` | — | `focus-column-left;` |
| `Mod+Right` | — | `focus-column-right;` |
| `Mod+Up` | — | `focus-window-up;` |
| `Mod+Down` | — | `focus-window-down;` |
| `Mod+K` | Focus left (60%) | `focus-column-left;` |
| `Mod+L` | Focus right (60%) | `focus-column-right;` |
| `Mod+J` | Focus up (60%) | `focus-window-up;` |
| `Mod+M` | Focus down (60%) | `focus-window-down;` |
| `Mod+Shift+Left` | Move column left | `move-column-left;` |
| `Mod+Shift+Right` | Move column right | `move-column-right;` |
| `Mod+Shift+Up` | Move window up | `move-window-up;` |
| `Mod+Shift+Down` | Move window down | `move-window-down;` |
| `Mod+Shift+K` | Move column left (60%) | `move-column-left;` |
| `Mod+Shift+L` | Move column right (60%) | `move-column-right;` |
| `Mod+Shift+J` | Move window up (60%) | `move-window-up;` |
| `Mod+Shift+M` | Move window down (60%) | `move-window-down;` |
| `Mod+Home` | — | `focus-column-first;` |
| `Mod+End` | — | `focus-column-last;` |
| `Mod+CTRL+Home` | — | `move-column-to-first;` |
| `Mod+CTRL+End` | — | `move-column-to-last;` |

// ─── Monitores ───
| `Mod+Alt+Left` | — | `focus-monitor-left;` |
| `Mod+Alt+Right` | — | `focus-monitor-right;` |
| `Mod+Alt+Up` | — | `focus-monitor-up;` |
| `Mod+Alt+Down` | — | `focus-monitor-down;` |
| `Mod+Shift+CTRL+Left` | — | `move-column-to-monitor-left;` |
| `Mod+Shift+CTRL+Right` | — | `move-column-to-monitor-right;` |
| `Mod+Shift+CTRL+Up` | — | `move-column-to-monitor-up;` |
| `Mod+Shift+CTRL+Down` | — | `move-column-to-monitor-down;` |

// ─── Workspaces ───
| `Mod+1` | — | `focus-workspace 1;` |
| `Mod+2` | — | `focus-workspace 2;` |
| `Mod+3` | — | `focus-workspace 3;` |
| `Mod+4` | — | `focus-workspace 4;` |
| `Mod+5` | — | `focus-workspace 5;` |
| `Mod+6` | — | `focus-workspace 6;` |
| `Mod+7` | — | `focus-workspace 7;` |
| `Mod+8` | — | `focus-workspace 8;` |
| `Mod+9` | — | `focus-workspace 9;` |
| `Mod+Shift+1` | — | `move-column-to-workspace 1;` |
| `Mod+Shift+2` | — | `move-column-to-workspace 2;` |
| `Mod+Shift+3` | — | `move-column-to-workspace 3;` |
| `Mod+Shift+4` | — | `move-column-to-workspace 4;` |
| `Mod+Shift+5` | — | `move-column-to-workspace 5;` |
| `Mod+Shift+6` | — | `move-column-to-workspace 6;` |
| `Mod+Shift+7` | — | `move-column-to-workspace 7;` |
| `Mod+Shift+8` | — | `move-column-to-workspace 8;` |
| `Mod+Shift+9` | — | `move-column-to-workspace 9;` |
| `Mod+TAB` | — | `focus-workspace-previous;` |
| `Mod+WheelScrollDown` | — | `focus-workspace-down;` |
| `Mod+WheelScrollUp` | — | `focus-workspace-up;` |
| `Mod+CTRL+WheelScrollDown` | — | `move-column-to-workspace-down;` |
| `Mod+CTRL+WheelScrollUp` | — | `move-column-to-workspace-up;` |
| `Mod+WheelScrollRight` | — | `focus-column-right;` |
| `Mod+WheelScrollLeft` | — | `focus-column-left;` |
| `Mod+CTRL+WheelScrollRight` | — | `move-column-right;` |
| `Mod+CTRL+WheelScrollLeft` | — | `move-column-left;` |

// ─── Layout (ancho / alto) ───
| `Mod+ntilde` | Shrink column | `set-column-width "-10%";` |
| `Mod+braceleft` | Grow column | `set-column-width "+10%";` |
| `Mod+Shift+ntilde` | Shrink height | `set-window-height "-10%";` |
| `Mod+Shift+braceleft` | Grow height | `set-window-height "+10%";` |

// ─── Column stack / tabs (como grupos de Hyprland) ───
| `Mod+V` | Toggle floating | `toggle-window-floating;` |
| `Mod+B` | Toggle column tabs | `toggle-column-tabbed-display;` |

// ─── Modos ───
| `Mod+T` | Stack into column | `consume-window-into-column;` |
| `Mod+F` | Fullscreen | `fullscreen-window;` |

// ─── Screenshots ───
| `CTRL+Shift+1` | — | `screenshot;` |
| `CTRL+Shift+2` | — | `screenshot-screen;` |
| `CTRL+Shift+3` | — | `screenshot-window;` |

// ─── Sistema ───
| `Mod+ESCAPE` | — | `toggle-keyboard-shortcuts-inhibit;` |
| `Mod+Shift+P` | — | `power-off-monitors;` |
| `CTRL+ALT+Delete` | — | `quit;` |

## Intent (do not lose)

- Super+Space → Noctalia launcher
- Super+Q → kitty
- Super+W → zen-browser script
- Super+E → nautilus
- Super+V → toggle floating
- Super+T → stack into column (Hyprland: group/togglegroup)
- Super+B → column tabs (Hyprland: group)
- Super+ñ shrink width / Super+{ grow width
- Super+Shift+ñ/ { height
- Super+Shift+W next wallpaper
- Super+Shift+I wallpaper selector
- Super+O overview
- Super+scroll workspace up/down
- Super+Shift+scroll move window to workspace
- Super+Ctrl+scroll move column to workspace
- Media keys → noctalia IPC volume/brightness/media
- Super+C close, Super+F fullscreen

## Layout preferences

- default column width 0.5
- center-focused-column always (Hyprland: different model — center floating / master)
- gaps 16
- square corners (radius 0)
- compact frame shadow (softness 6, offset y=5, color #000000cc)
- border width 3
- focus-follows-mouse with max-scroll 0%
- keyboard latam
- prefer-no-csd
- background transparent for wallpaper
- no hot corners

## Noctalia

- useWallpaperColors true, generationMethod muted
- templates: kitty, btop, cava, starship, zenBrowser, discord user template
- enable hyprland template when migrating; disable niri template
- colorGeneration hook: fix-zen-noctalia-theme
- wallpaper dir: ~/Wallpapers

## Scripts to port

- next-wallpaper (compositor-agnostic if noctalia IPC)
- fix-zen-noctalia-theme (ok as-is)
- zen-browser (uses niri msg — rewrite for hyprctl)
