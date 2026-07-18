# Repository layout

```
T7-Dotfiles/
├── config/
│   ├── niri/              # compositor (keybinds, layout, shadows, rules)
│   ├── noctalia/          # shell settings + Matugen user templates
│   ├── kitty/  fish/  starship.toml
│   ├── vesktop/  code-oss/  zen/chrome/
│   ├── btop/  cava/  fastfetch/  aesthetic/  gtk-3.0/
├── scripts/               # next-wallpaper · fix-zen · zen-browser
├── wallpapers/
├── screenshots/
├── docs/
├── install.sh
└── LICENSE
```

## Color pipeline

1. Wallpaper change (selector / `Super+Shift+W`)
2. Noctalia Material You (`muted` + wallpaper colors)
3. Built-in: Kitty, Niri, Starship, Zen, btop, cava
4. User templates: Vesktop, fastfetch, aesthetic.env, VS Code
5. Hook: `fix-zen-noctalia-theme` (clean CSS import chain)

## Notes

- Paths use `@@HOME@@` → expanded by `install.sh`
- `noctalia.kdl`, kitty theme, colors.json are **samples** (regenerated live)
- Border **colors** come from Noctalia; border **width + shadow frame** from `cfg/border-width.kdl`
