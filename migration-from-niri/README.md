# T7 Hyprland migration pack

Frozen snapshot of your **Niri rice** before switching to Hyprland.  
Use this folder when rewriting configs — do not delete.

## Contents

| Path | What |
|------|------|
| `niri-export/` | Full `~/.config/niri` (keybinds, layout, rules, shadows…) |
| `noctalia-export/` | settings, templates, user-templates |
| `scripts-export/` | next-wallpaper, fix-zen, zen-browser |
| `apps-export/` | kitty, fish, starship, vesktop theme, gtk, btop, cava… |
| `code-oss-export/` | VS Code settings (Noctalia + readable tokens) |
| `notes/KEYBINDS_NIRI.md` | Table of binds to port |
| `notes/PREFERENCES.md` | What must survive the move |

## Install Hyprland (CachyOS)

```bash
sudo pacman -S hyprland xdg-desktop-portal-hyprland hyprland-qt-support
```

Optional later: `hypridle` `hyprlock` (if you leave lock to Noctalia, optional).

**Do not remove niri yet.** Both sessions can coexist:

- Login screen (SDDM) → choose **Hyprland** or **Niri**
- First Hyprland login generates default `~/.config/hypr/`

## After first Hyprland login (next session with Grok)

1. Port keybinds from `notes/KEYBINDS_NIRI.md` → `hyprland.conf`
2. Autostart Noctalia: `qs -c noctalia-shell`
3. Enable Noctalia template `hyprland`, disable `niri`
4. Multi-monitor + lid rules
5. Adapt `zen-browser` script to `hyprctl`

## Keep Noctalia colors

Same pipeline: wallpaper → Material You muted → kitty/starship/vesktop/zen/…
Only compositor template changes: **niri → hyprland**.
