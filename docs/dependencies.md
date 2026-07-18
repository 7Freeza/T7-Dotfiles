# Dependencies

Tested on **CachyOS** with **Niri** + **Noctalia Shell**.

## Required

| Package | Role |
|---------|------|
| `niri` | Wayland compositor |
| `noctalia-shell` | Bar, theming, wallpaper IPC |
| `quickshell` (`qs`) | Noctalia runtime |
| `kitty` | Terminal |
| `starship` | Prompt |
| `fish` | Shell |
| `fastfetch` | Terminal banner |
| `python3` | Wallpaper cycle + Zen scripts |

## Themed apps

| Package | Notes |
|---------|--------|
| `zen-browser` | Noctalia template + `fix-zen-noctalia-theme` hook |
| `vesktop` | `discord.css` → system24 theme |
| `code` / `code-oss` | Noctalia VS Code theme extension |
| `btop` / `cava` | Built-in Noctalia templates |

## Optional terminal toys

Used via `config/fish/conf.d/aesthetic.fish`:

- `cbonsai`, `lavat`, `pipes.sh`, `tty-clock`
- `terminal-rain-lightning` (`yay -S terminal-rain-lightning` → `rain`)

## Fonts / cursors

- Maple Mono (Vesktop system24)
- System monospace (Kitty)
- Adwaita Sans (Noctalia UI)
- capitaine-cursors
