#!/usr/bin/env bash
# T7 Dotfiles installer — Niri + Noctalia aesthetic stack
# Safe defaults: backup existing configs, expand @@HOME@@, optional symlink mode.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_ROOT="${DOTFILES_BACKUP:-$HOME/.config/t7-dotfiles-backup-$(date +%Y%m%d-%H%M%S)}"
# 1 = symlink config trees into ~/.config (recommended for git tracking)
# 0 = copy files
LINK="${DOTFILES_LINK:-1}"
INSTALL_WALLPAPERS="${DOTFILES_WALLPAPERS:-1}"

info()  { printf '==> %s\n' "$*"; }
warn()  { printf '!!> %s\n' "$*" >&2; }

backup_if_exists() {
  local target="$1"
  if [[ -e "$target" || -L "$target" ]]; then
    mkdir -p "$BACKUP_ROOT"
    local base
    base="$(basename "$target")"
    # avoid clobbering same-name backups
    if [[ -e "$BACKUP_ROOT/$base" ]]; then
      base="${base}.$(date +%H%M%S)"
    fi
    mv "$target" "$BACKUP_ROOT/$base"
    info "Backup: $target → $BACKUP_ROOT/$base"
  fi
}

expand_home() {
  # Replace @@HOME@@ tokens with the installing user's $HOME
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

# ---------- start ----------
info "T7 Dotfiles: $DOTFILES"
mkdir -p "$HOME/.local/bin" "$HOME/Wallpapers" "$HOME/.cache/noctalia"

# Core XDG config trees
for dir in niri kitty fish gtk-3.0 btop cava aesthetic fastfetch; do
  install_config_dir "$dir"
done

# Noctalia cannot be a single symlink: settings.json / user-templates.toml
# contain @@HOME@@ tokens that must expand to real paths without rewriting the repo.
backup_if_exists "$HOME/.config/noctalia"
mkdir -p "$HOME/.config/noctalia/templates"
if [[ "$LINK" == "1" ]]; then
  # Link static pieces; materialize token files as real files.
  link_path "$DOTFILES/config/noctalia/templates" "$HOME/.config/noctalia/templates"
  for f in plugins.json colors.json; do
    link_path "$DOTFILES/config/noctalia/$f" "$HOME/.config/noctalia/$f"
  done
else
  copy_tree "$DOTFILES/config/noctalia/templates" "$HOME/.config/noctalia/templates"
  cp "$DOTFILES/config/noctalia/plugins.json" "$HOME/.config/noctalia/plugins.json"
  cp "$DOTFILES/config/noctalia/colors.json" "$HOME/.config/noctalia/colors.json"
fi
expand_home "$DOTFILES/config/noctalia/settings.json" "$HOME/.config/noctalia/settings.json"
expand_home "$DOTFILES/config/noctalia/user-templates.toml" "$HOME/.config/noctalia/user-templates.toml"
info "noctalia (settings + user-templates expanded; templates linked/copied)"

# Starship layout — always copy (Noctalia appends [palettes.noctalia] at runtime;
# linking would rewrite the clean template inside the repo).
backup_if_exists "$HOME/.config/starship.toml"
cp "$DOTFILES/config/starship.toml" "$HOME/.config/starship.toml"
info "starship.toml"

# Kitty theme symlink (Noctalia also rewrites themes/noctalia.conf)
mkdir -p "$HOME/.config/kitty/themes"
if [[ ! -e "$HOME/.config/kitty/themes/noctalia.conf" ]]; then
  cp "$DOTFILES/config/kitty/themes/noctalia.conf" "$HOME/.config/kitty/themes/noctalia.conf"
fi
ln -sfn themes/noctalia.conf "$HOME/.config/kitty/current-theme.conf"

# Vesktop: theme + non-session settings only
mkdir -p "$HOME/.config/vesktop/themes"
cp "$DOTFILES/config/vesktop/themes/system24.theme.css" \
  "$HOME/.config/vesktop/themes/system24.theme.css"
if [[ ! -f "$HOME/.config/vesktop/settings.json" ]]; then
  cp "$DOTFILES/config/vesktop/settings.json" "$HOME/.config/vesktop/settings.json"
else
  info "Keeping existing Vesktop settings.json (theme file updated)"
fi
info "vesktop theme"

# Code - OSS / VS Code User settings (theme only)
for code_dir in \
  "$HOME/.config/Code - OSS/User" \
  "$HOME/.config/Code/User" \
  "$HOME/.config/VSCodium/User"
do
  mkdir -p "$code_dir"
  if [[ ! -f "$code_dir/settings.json" ]]; then
    cp "$DOTFILES/config/code-oss/User/settings.json" "$code_dir/settings.json"
  else
    # merge theme key non-destructively via python if available
    if command -v python3 >/dev/null 2>&1; then
      python3 - "$code_dir/settings.json" "$DOTFILES/config/code-oss/User/settings.json" <<'PY'
import json, sys
from pathlib import Path
dest, src = Path(sys.argv[1]), Path(sys.argv[2])
try:
    d = json.loads(dest.read_text() or "{}")
except Exception:
    d = {}
s = json.loads(src.read_text())
d.setdefault("workbench.colorTheme", s.get("workbench.colorTheme", "NoctaliaTheme"))
d.setdefault("window.autoDetectColorScheme", s.get("window.autoDetectColorScheme", False))
dest.write_text(json.dumps(d, indent=4) + "\n")
PY
    fi
  fi
done
info "editor theme settings"

# Scripts
for script in next-wallpaper fix-zen-noctalia-theme zen-browser; do
  install -m 755 "$DOTFILES/scripts/$script" "$HOME/.local/bin/$script"
done
info "scripts → ~/.local/bin"

# Wallpapers
if [[ "$INSTALL_WALLPAPERS" == "1" ]] && [[ -d "$DOTFILES/wallpapers" ]]; then
  shopt -s nullglob
  local_count=0
  for f in "$DOTFILES/wallpapers"/*; do
    [[ -f "$f" ]] || continue
    base="$(basename "$f")"
    if [[ ! -e "$HOME/Wallpapers/$base" ]]; then
      cp "$f" "$HOME/Wallpapers/$base"
      local_count=$((local_count + 1))
    fi
  done
  shopt -u nullglob
  info "wallpapers: copied $local_count new file(s) → ~/Wallpapers"
fi

# Zen chrome chain (profile-agnostic; script finds chrome/ dirs)
if [[ -x "$HOME/.local/bin/fix-zen-noctalia-theme" ]]; then
  "$HOME/.local/bin/fix-zen-noctalia-theme" 2>/dev/null \
    || warn "Zen theme hook skipped (Zen may not be installed yet)."
fi

cat <<EOF

Installed T7 Dotfiles.

Next:
  1. Dependencies → docs/dependencies.md
  2. Log out/in or restart niri + noctalia-shell
  3. In Noctalia, pick a wallpaper once (generates live colors)
  4. Vesktop: enable the system24 theme under Themes
  5. VS Code: install Noctalia theme extension if colors should follow wallpaper

Keybinds (Niri Mod = Super):
  Super+Shift+W   next wallpaper
  Super+Shift+I   wallpaper selector
  Super+Space     launcher
  Super+Q         kitty
  Super+W         zen-browser

Backup (if any): ${BACKUP_ROOT}
Mode: LINK=${LINK}  WALLPAPERS=${INSTALL_WALLPAPERS}
EOF
