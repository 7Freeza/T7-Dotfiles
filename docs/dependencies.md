# Dependencies — T7 Dotfiles v3 (Hyprland + Noctalia)

Target: **CachyOS / Arch** (adapt package names elsewhere).

## Required

| Package / component | Why |
|---------------------|-----|
| [Hyprland](https://hyprland.org/) **≥ 0.56** (Lua config) | Compositor |
| [Noctalia Shell](https://github.com/noctalia-dev/noctalia-shell) + `qs` (quickshell) | Bar, launcher, lock, wallpaper IPC |
| `kitty` | Terminal |
| `fish` + `starship` | Shell prompt stack |
| `pipewire` + `wireplumber` | Audio (media keys) |
| `grim` + `slurp` + `wl-clipboard` | Screenshots (`t7-screenshot`) |
| `jq` / `python3` | Scripts + install expand |

## Strongly recommended

| Package | Why |
|---------|-----|
| `zen-browser-bin` (AUR) or Firefox | Browser binds |
| `vesktop` | Discord + system24 theme |
| `nautilus` | File manager bind |
| `capitaine-cursors` | Cursor theme |
| `maple-mono-nf` / Nerd Font | Terminal + Discord fonts |
| `btop` `cava` `fastfetch` | Aesthetic stack |
| `code` / Code - OSS | Editor theme settings |

## Optional / hardware

| Package | Why |
|---------|-----|
| `brightnessctl` or sysfs backlight | Brightness keys via Noctalia |
| Multi-monitor + lid | `t7-display` (included) |

## Install Noctalia

Follow upstream docs for your distro. On Arch-based:

```bash
# example — check current AUR/package name
yay -S noctalia-shell   # or quickshell + noctalia package
```

Confirm:

```bash
qs -c noctalia-shell --version
hyprctl version
```

## After `./install.sh`

1. Log into a **Hyprland** session (SDDM/GDM).
2. Enable display daemon (if multi-monitor/lid):

   ```bash
   systemctl --user daemon-reload
   systemctl --user enable --now t7-display.service
   ```

3. Start / restart Noctalia: `qs -c noctalia-shell &`
4. Pick a wallpaper once (generates Material You colors).
5. Vesktop → Settings → Themes → enable **system24**.

## Legacy: Niri

Niri configs remain under `config/niri/` for reference/migration.  
**v3 primary target is Hyprland.** See [migration-from-niri/](../migration-from-niri/) if you still switch.
