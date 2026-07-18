# T7 Dotfiles — fish entrypoint
# Source distro defaults if present (CachyOS), then Starship.

if test -f /usr/share/cachyos-fish-config/cachyos-config.fish
    source /usr/share/cachyos-fish-config/cachyos-config.fish
end

if command -q starship
    starship init fish | source
end
