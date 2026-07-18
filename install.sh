#!/usr/bin/env bash
# T7 Dotfiles installer — Niri + Noctalia (aesthetic stack)
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_ROOT="${DOTFILES_BACKUP:-$HOME/.config/t7-dotfiles-backup-$(date +%Y%m%d-%H%M%S)}"
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

info "T7 Dotfiles: $DOTFILES"
mkdir -p "$HOME/.local/bin" "$HOME/Wallpapers" "$HOME/.cache/noctalia"

for dir in niri kitty fish gtk-3.0 btop cava aesthetic fastfetch; do
  install_config_dir "$dir"
done

# Noctalia: never symlink settings (@@HOME@@ tokens)
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

# Starship always copied (Noctalia injects palette at runtime)
backup_if_exists "$HOME/.config/starship.toml"
cp "$DOTFILES/config/starship.toml" "$HOME/.config/starship.toml"
info "starship.toml"

mkdir -p "$HOME/.config/kitty/themes"
[[ -e "$HOME/.config/kitty/themes/noctalia.conf" ]] || \
  cp "$DOTFILES/config/kitty/themes/noctalia.conf" "$HOME/.config/kitty/themes/noctalia.conf"
ln -sfn themes/noctalia.conf "$HOME/.config/kitty/current-theme.conf"

# Vesktop theme only
mkdir -p "$HOME/.config/vesktop/themes"
[[ -f "$DOTFILES/config/vesktop/themes/system24.theme.css" ]] && \
  cp "$DOTFILES/config/vesktop/themes/system24.theme.css" "$HOME/.config/vesktop/themes/system24.theme.css"
if [[ ! -f "$HOME/.config/vesktop/settings.json" ]]; then
  cp "$DOTFILES/config/vesktop/settings.json" "$HOME/.config/vesktop/settings.json"
fi
info "vesktop theme"

for code_dir in \
  "$HOME/.config/Code - OSS/User" \
  "$HOME/.config/Code/User" \
  "$HOME/.config/VSCodium/User"
do
  mkdir -p "$code_dir"
  if [[ ! -f "$code_dir/settings.json" ]]; then
    cp "$DOTFILES/config/code-oss/User/settings.json" "$code_dir/settings.json"
  fi
done
info "editor theme settings"

for script in next-wallpaper fix-zen-noctalia-theme zen-browser; do
  install -m 755 "$DOTFILES/scripts/$script" "$HOME/.local/bin/$script"
done
info "scripts → ~/.local/bin"

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
  info "wallpapers: copied $n new file(s)"
fi

if [[ -x "$HOME/.local/bin/fix-zen-noctalia-theme" ]]; then
  "$HOME/.local/bin/fix-zen-noctalia-theme" 2>/dev/null \
    || warn "Zen theme hook skipped (Zen may not be installed)."
fi

cat <<EOF

Installed T7 Dotfiles.

Next:
  1. docs/dependencies.md
  2. Restart niri + noctalia-shell
  3. Pick a wallpaper once (generates colors)
  4. Vesktop → enable system24 theme
  5. VS Code → NoctaliaTheme extension

Keybinds:
  Super+Shift+W   next wallpaper
  Super+V         toggle floating
  Super+ñ / Super+{   shrink / grow width
  Super+Space     launcher

Backup: ${BACKUP_ROOT}
EOF
