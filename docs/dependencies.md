# Dependencies

Tested on **CachyOS** with **Niri** + **Noctalia Shell**.

## Required

| Package | Role |
|---------|------|
| `niri` | Wayland compositor |
| `noctalia-shell` | Bar, shell UI, Material You colors, wallpaper IPC |
| `quickshell` (`qs`) | Noctalia runtime |
| `kitty` | Terminal |
| `starship` | Prompt |
| `fish` | Shell |
| `fastfetch` | Terminal system banner |
| `python3` | Wallpaper cycle + Zen theme scripts |

## Themed applications

| Package | How colors land |
|---------|-----------------|
| `zen-browser` | Noctalia `zenBrowser` template + `fix-zen-noctalia-theme` hook |
| `vesktop` | Template `discord.css` → `~/.config/vesktop/themes/system24.theme.css` |
| `code` / `code-oss` | Noctalia VS Code theme extension (`NoctaliaTheme`) |
| `btop` | Built-in Noctalia template |
| `cava` | Built-in Noctalia template |

## Optional terminal toys

Loaded via `config/fish/conf.d/aesthetic.fish` (colors follow wallpaper):

- `cbonsai`
- `lavat`
- `pipes.sh`
- `tty-clock`

## Fonts

- **Maple Mono** (or Maple Mono NF) — Vesktop/system24 theme
- System monospace — Kitty (`font_family monospace`)
- **Adwaita Sans** — Noctalia UI (see `settings.json` → `ui.fontDefault`)
- **capitaine-cursors** — cursor theme (GTK + Niri)

## Not included on purpose

- Account tokens, Vesktop session data, Zen passwords/cookies
- Spicetify (stock Spotify)
- Hardware-specific display modes (see `config/niri/cfg/display.kdl`, commented)
