# T7 Display System

Single authority for multi-monitor + laptop lid on Hyprland.

## Components

| Path | Role |
|------|------|
| `~/.local/bin/t7-display` | Brain (policy, apply, daemon, CLI) |
| `~/.config/t7/display.conf` | Outputs, positions, timings |
| `~/.config/systemd/user/t7-display.service` | Long-running daemon |
| `~/.config/hypr/hyprland.lua` | Safe static defaults + boot `ensure` + lid binds |

## Policy

1. No HDMI → **laptop-only**
2. HDMI + lid open → **both** (HDMI `0x0`, eDP `1920x0`)
3. HDMI + lid closed → **external-only** (eDP forced off)
4. HDMI + lid unknown → **external-only** (clamshell-safe)

## Commands

```bash
t7-display status    # live state
t7-display auto      # reconcile now
t7-display doctor    # diagnostics
t7-display ensure    # start service + reconcile (Hyprland uses this)
```

```bash
systemctl --user status t7-display.service
journalctl --user -u t7-display.service -f
tail -f ~/.cache/t7-display.log
```

## Safety rules

- Never leave zero active monitors (enable primary before disable)
- Lid closed ⇒ eDP must stay off
- `flock` serializes applies
- Rate-limited enforces (protect Hyprland)
- Never reloads or kills Hyprland
- Noctalia restart is last resort + debounced
- Static eDP starts **disabled** in hyprland.lua

## After editing conf

```bash
systemctl --user restart t7-display.service
# or
t7-display auto
```
