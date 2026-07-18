<div align="center">

# T7 Dotfiles

**Wallpaper-driven Material You** on [Niri](https://github.com/YaLTeR/niri) + [Noctalia Shell](https://github.com/noctalia-dev/noctalia-shell)

[**7Freeza**](https://github.com/7Freeza) · CachyOS · Kitty · Starship · Zen · Vesktop · Code - OSS

[![License: MIT](https://img.shields.io/badge/License-MIT-8b949e?style=flat-square)](LICENSE)
[![Niri](https://img.shields.io/badge/WM-Niri-58a6ff?style=flat-square)](https://github.com/YaLTeR/niri)
[![Noctalia](https://img.shields.io/badge/Shell-Noctalia-6e7681?style=flat-square)](https://github.com/noctalia-dev/noctalia-shell)

<br/>

<img src="screenshots/01-azul.png" alt="T7 rice — cool palette" width="920"/>

</div>

---

## Features

- **Live Material You colors** from the wallpaper (`muted` generation)
- **Whole desktop in sync** — bar, Kitty, Starship, Niri borders, Zen, Vesktop (system24), VS Code, btop, cava, fastfetch
- **Animated wallpaper cycle** — `Super+Shift+W` recolors the rice with the wall
- **Compact frame shadow** — square corners, solid drop shadow
- **Half-width by default** — columns open at 50%
- **Floating windows** — `Super+V`
- **Install script** + shipped wallpapers

---

## Gallery

### Cool palette

| | |
|:---:|:---:|
| <img src="screenshots/01-azul.png" width="420"/> | <img src="screenshots/02-azul.png" width="420"/> |
| <img src="screenshots/03-azul.png" width="420"/> | <img src="screenshots/04-azul.png" width="420"/> |

### Warm palette

| | |
|:---:|:---:|
| <img src="screenshots/05-amarillo.png" width="420"/> | <img src="screenshots/06-amarillo.png" width="420"/> |
| <img src="screenshots/07-amarillo.png" width="420"/> | <img src="screenshots/08-amarillo.png" width="420"/> |

### Wallpaper cycle

Colors follow the wall across the rice (terminal, Discord, editor, bar).

<div align="center">
  <img src="screenshots/wallpaper-cycle.gif" alt="Wallpaper cycle with live recolor" width="720"/>
</div>

Full clip: [`screenshots/wallpaper-cycle.mp4`](screenshots/wallpaper-cycle.mp4)

---

## Quick start

> [!NOTE]
> Install **Niri**, **Noctalia Shell**, and deps first.  
> See [docs/dependencies.md](docs/dependencies.md).

```bash
git clone https://github.com/7Freeza/T7-Dotfiles.git ~/T7-Dotfiles
cd ~/T7-Dotfiles
./install.sh
```

Restart niri + noctalia-shell, then **pick a wallpaper once** so colors generate.

| Variable | Default | Effect |
|----------|---------|--------|
| `DOTFILES_LINK=0` | `1` (symlink) | Copy files instead |
| `DOTFILES_WALLPAPERS=0` | `1` | Skip wallpaper install |

---

## Keybinds

| Key | Action |
|-----|--------|
| `Super+Space` | Launcher |
| `Super+Q` | Kitty |
| `Super+W` | Zen Browser |
| `Super+V` | Toggle floating |
| `Super+T` | Stack into column |
| `Super+B` | Column tabs |
| `Super+ñ` / `Super+{` | Shrink / grow width |
| `Super+Shift+ñ` / `Super+Shift+{` | Shrink / grow height |
| `Super+Shift+W` | Next wallpaper |
| `Super+Shift+I` | Wallpaper selector |
| `Super+O` | Overview |

Full list: `config/niri/cfg/keybinds.kdl`.

---

## Color pipeline

```text
wallpaper change
      ↓
Noctalia Material You (muted)
      ↓
Kitty · Niri · Starship · Zen · btop · cava
Vesktop · fastfetch · aesthetic.env · VS Code
      ↓
fix-zen-noctalia-theme (clean Zen CSS chain)
```

---

## Layout

```text
config/     niri · noctalia · kitty · fish · vesktop · zen · …
scripts/    next-wallpaper · fix-zen-noctalia-theme · zen-browser
wallpapers/
screenshots/
docs/
install.sh
```

More detail: [docs/structure.md](docs/structure.md).

---

## Post-install

1. Dependencies from [docs/dependencies.md](docs/dependencies.md)
2. Restart **niri** + **noctalia-shell**
3. Set a wallpaper in Noctalia
4. **Vesktop** → Themes → **system24**
5. **Code - OSS** → Noctalia theme extension → `NoctaliaTheme`

---

## Privacy

Aesthetic configs only — no Discord sessions, browser logins, or personal paths.  
Machine paths use `@@HOME@@` and expand on install.

---

## Credits

- [Niri](https://github.com/YaLTeR/niri)
- [Noctalia Shell](https://github.com/noctalia-dev/noctalia-shell)
- [system24](https://github.com/refact0r/system24) — Vesktop theme base  
- Wallpapers: respect original artists if redistributed

## License

[MIT](LICENSE) for configs and scripts.
