#!/usr/bin/env bash
# T7 Dotfiles v3 installer — Hyprland + Noctalia
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_ROOT="${DOTFILES_BACKUP:-$HOME/.config/t7-dotfiles-backup-$(date +%Y%m%d-%H%M%S)}"
LINK="${DOTFILES_LINK:-1}"
INSTALL_WALLPAPERS="${DOTFILES_WALLPAPERS:-1}"
INSTALL_NIRI="${DOTFILES_NIRI:-0}"   # legacy optional

info()  { printf '==> %s\n' "$*"; }
warn()  { printf '!!> %s\n' "$*" >&2; }

backup_if_exists() {
  local target="$1"
  if [[ -e "$target" || -L "$target" ]]; then
    mkdir -p "$BACKUP_ROOT"
    local base
    base="$(basename "$target")"
    [[ -e "$BACKUP_ROOT/$base" ]] && base="${base}.$(date +%H%M%S)"
    mv "$target" "$BACKUP_ROOT/$base"
    info "Backup: $target → $BACKUP_ROOT/$base"
  fi
}

expand_home() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  sed "s|@@HOME@@|$HOME|g" "$src" > "$dest"
}

link_path() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  ln -sfn "$src" "$dest"
}

copy_tree() {
  local src="$1" dest="$2"
  mkdir -p "$dest"
  if command -v rsync >/dev/null 2>&1; then
    rsync -a "$src/" "$dest/"
  else
    cp -a "$src/." "$dest/"
  fi
}

install_config_dir() {
  local name="$1"
  local src="$DOTFILES/config/$name"
  local dest="$HOME/.config/$name"
  [[ -d "$src" ]] || return 0
  backup_if_exists "$dest"
  if [[ "$LINK" == "1" ]]; then
    link_path "$src" "$dest"
  else
    mkdir -p "$dest"
    copy_tree "$src" "$dest"
  fi
  info "config/$name"
}

info "T7 Dotfiles v3 (Hyprland + Noctalia): $DOTFILES"
mkdir -p "$HOME/.local/bin" "$HOME/Wallpapers" "$HOME/.cache/noctalia" \
  "$HOME/.config/hypr" "$HOME/.config/xkb" "$HOME/.config/t7" \
  "$HOME/.config/systemd/user"

# --- Hyprland (always copy lua/conf so @@ paths are fine; no secrets) ---
backup_if_exists "$HOME/.config/hypr/hyprland.lua"
backup_if_exists "$HOME/.config/hypr/hyprland.conf"
mkdir -p "$HOME/.config/hypr/noctalia"
cp "$DOTFILES/config/hypr/hyprland.lua" "$HOME/.config/hypr/hyprland.lua"
cp "$DOTFILES/config/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
[[ -f "$DOTFILES/config/hypr/noctalia/noctalia-colors.conf" ]] && \
  cp "$DOTFILES/config/hypr/noctalia/noctalia-colors.conf" "$HOME/.config/hypr/noctalia/noctalia-colors.conf"
info "hyprland.lua + conf"

# --- App configs ---
for dir in kitty fish gtk-3.0 btop cava aesthetic fastfetch; do
  install_config_dir "$dir"
done

if [[ "$INSTALL_NIRI" == "1" ]]; then
  install_config_dir "niri"
  info "niri (legacy, DOTFILES_NIRI=1)"
fi

# --- Noctalia: never symlink settings (@@HOME@@ tokens) ---
backup_if_exists "$HOME/.config/noctalia"
mkdir -p "$HOME/.config/noctalia/templates"
if [[ "$LINK" == "1" ]]; then
  link_path "$DOTFILES/config/noctalia/templates" "$HOME/.config/noctalia/templates"
  for f in plugins.json colors.json; do
    [[ -f "$DOTFILES/config/noctalia/$f" ]] && link_path "$DOTFILES/config/noctalia/$f" "$HOME/.config/noctalia/$f"
  done
else
  copy_tree "$DOTFILES/config/noctalia/templates" "$HOME/.config/noctalia/templates"
  cp "$DOTFILES/config/noctalia/plugins.json" "$HOME/.config/noctalia/plugins.json"
  [[ -f "$DOTFILES/config/noctalia/colors.json" ]] && cp "$DOTFILES/config/noctalia/colors.json" "$HOME/.config/noctalia/colors.json"
fi
expand_home "$DOTFILES/config/noctalia/settings.json" "$HOME/.config/noctalia/settings.json"
expand_home "$DOTFILES/config/noctalia/user-templates.toml" "$HOME/.config/noctalia/user-templates.toml"
info "noctalia (settings expanded)"

# Starship
backup_if_exists "$HOME/.config/starship.toml"
cp "$DOTFILES/config/starship.toml" "$HOME/.config/starship.toml"
info "starship.toml"

mkdir -p "$HOME/.config/kitty/themes"
[[ -e "$HOME/.config/kitty/themes/noctalia.conf" ]] || \
  cp "$DOTFILES/config/kitty/themes/noctalia.conf" "$HOME/.config/kitty/themes/noctalia.conf" 2>/dev/null || true
ln -sfn themes/noctalia.conf "$HOME/.config/kitty/current-theme.conf" 2>/dev/null || true

# Vesktop — theme only (never sessionData / tokens)
mkdir -p "$HOME/.config/vesktop/themes"
[[ -f "$DOTFILES/config/vesktop/themes/system24.theme.css" ]] && \
  cp "$DOTFILES/config/vesktop/themes/system24.theme.css" "$HOME/.config/vesktop/themes/system24.theme.css"
if [[ ! -f "$HOME/.config/vesktop/settings.json" ]]; then
  cp "$DOTFILES/config/vesktop/settings.json" "$HOME/.config/vesktop/settings.json"
fi
info "vesktop system24 theme"

# Editor theme settings (do not overwrite existing)
for code_dir in \
  "$HOME/.config/Code - OSS/User" \
  "$HOME/.config/Code/User" \
  "$HOME/.config/VSCodium/User"
do
  mkdir -p "$code_dir"
  if [[ ! -f "$code_dir/settings.json" ]] && [[ -f "$DOTFILES/config/code-oss/User/settings.json" ]]; then
    cp "$DOTFILES/config/code-oss/User/settings.json" "$code_dir/settings.json"
  fi
done
info "editor settings (if missing)"

# Zen chrome hooks (optional)
if [[ -d "$DOTFILES/config/zen/chrome" ]]; then
  info "zen chrome themes shipped — run fix-zen-noctalia-theme after install"
fi

# t7 display policy + xkb
cp "$DOTFILES/config/t7/display.conf" "$HOME/.config/t7/display.conf"
[[ -f "$DOTFILES/config/t7/README.md" ]] && cp "$DOTFILES/config/t7/README.md" "$HOME/.config/t7/README.md"
cp "$DOTFILES/config/xkb/"*.xkb "$HOME/.config/xkb/" 2>/dev/null || true
info "t7 display + xkb"

# systemd user unit
cp "$DOTFILES/config/systemd/user/t7-display.service" "$HOME/.config/systemd/user/t7-display.service"
systemctl --user daemon-reload 2>/dev/null || true
info "t7-display.service installed (enable with: systemctl --user enable --now t7-display.service)"

# Scripts
for script in next-wallpaper fix-zen-noctalia-theme zen-browser apply-noctalia-hypr-colors \
              t7-display t7-keyboard t7-screenshot; do
  [[ -f "$DOTFILES/scripts/$script" ]] || continue
  install -m 755 "$DOTFILES/scripts/$script" "$HOME/.local/bin/$script"
done
info "scripts → ~/.local/bin"

# Wallpapers
if [[ "$INSTALL_WALLPAPERS" == "1" ]] && [[ -d "$DOTFILES/wallpapers" ]]; then
  shopt -s nullglob
  n=0
  for f in "$DOTFILES/wallpapers"/*; do
    [[ -f "$f" ]] || continue
    base="$(basename "$f")"
    if [[ ! -e "$HOME/Wallpapers/$base" ]]; then
      cp "$f" "$HOME/Wallpapers/$base"
      n=$((n + 1))
    fi
  done
  shopt -u nullglob
  info "wallpapers: copied $n new file(s) → ~/Wallpapers"
fi

if [[ -x "$HOME/.local/bin/fix-zen-noctalia-theme" ]]; then
  "$HOME/.local/bin/fix-zen-noctalia-theme" 2>/dev/null \
    || warn "Zen theme hook skipped (Zen may not be installed)."
fi

cat <<EOF

Installed T7 Dotfiles v3 — Hyprland + Noctalia.

Next:
  1. docs/dependencies.md
  2. Log into Hyprland
  3. systemctl --user enable --now t7-display.service   # multi-monitor / lid
  4. qs -c noctalia-shell &
  5. Pick a wallpaper once (Material You colors)
  6. Vesktop → enable system24 theme
  7. Keybinds: docs/KEYBINDS.md

Gallery: screenshots/   |   Install walls: wallpapers/

Keybinds (highlights):
  Super+Space          launcher
  Super+Q / W / E      kitty / zen / files
  Super+V              float
  Super+Shift+W        next wallpaper
  Super+ñ / Super+{    resize width
  Ctrl+Shift+1         region screenshot

Backup: ${BACKUP_ROOT}
EOF
