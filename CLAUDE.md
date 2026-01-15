# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles repository containing configurations for a development environment across Linux (Hyprland) and macOS. Managed via symlinks from `~/dotfiles` to respective locations.

## Repository Structure

```
.zshrc                      # Shell config (Oh My Zsh, aliases, keybinds)
.config/
  nvim/                     # Neovim config (see .config/nvim/CLAUDE.md for details)
  tmux/tmux.conf            # Tmux config (prefix: C-a, vi keys, tpm plugins, theme detection)
  ghostty/config            # Ghostty terminal (auto-detects light/dark theme)
  hypr/                     # Hyprland window manager (Linux only)
    hyprland.conf           # Main config with keybinds and window rules
    hyprlock.conf           # Lock screen config
  waybar/                   # Status bar (Linux)
  wofi/                     # App launcher (Linux)
  starship.toml             # Starship prompt (bracketed-segments preset)
.local/bin/                 # Custom scripts
  tmux-sessionizer          # Create/switch tmux sessions from directories
  tmux-switch-session       # Switch between existing tmux sessions
  detect-system-theme       # Detect system theme (light/dark)
  sync-theme                # Sync theme across components (tmux, zsh)
```

## Key Conventions

- **Symlink installation**: Configs are symlinked from `~/dotfiles` to their target locations (e.g., `~/.config/nvim`)
- **Platform-specific**: NVM loads only on non-Darwin systems; SDKMAN loads on Darwin
- **Tmux-centric workflow**: Sessions managed via fzf-based scripts; history per-session

## Shell Keybinds (.zshrc)

| Keybind | Action |
|---------|--------|
| `Ctrl+F` | Open tmux-sessionizer (create/switch session from directory) |
| `Esc Esc` | Open tmux-switch-session (switch between sessions) |
| `Alt+P` | Reload .zshrc |

## Tmux Keybinds (tmux.conf)

| Keybind | Action |
|---------|--------|
| `C-a` | Prefix (rebound from C-b) |
| `prefix + f` | tmux-sessionizer |
| `prefix + Escape` | tmux-switch-session |
| `prefix + H` | Open nvim via sessionizer |
| `prefix + h/j/k/l` | Vim-style pane navigation |

## Hyprland Keybinds (Linux)

| Keybind | Action |
|---------|--------|
| `Super + Return` | Terminal (ghostty) |
| `Super + W` | Browser (brave) |
| `Super + R` | App launcher (wofi) |
| `Super + Q` | Kill window |
| `Super + H/J/K/L` | Move focus |
| `Super + 1-9` | Switch workspace |
| `Super + Shift + 1-9` | Move window to workspace |
| `Super + F` | Fullscreen |

## Workspace Layout (Hyprland)

- WS 1: Browser (DP-1)
- WS 2: AI Chat (DP-1)
- WS 3: Terminal (DP-2, fullscreen)
- WS 4: IDE (DP-2)
- WS 6: Mail
- WS 8: Spotify

## Theme System

**Theme Detection:**
- `detect-system-theme` script detects system-wide light/dark theme preference
- macOS: Reads `AppleInterfaceStyle` setting
- Linux: Checks GTK preferences and GNOME dconf settings

**Theme-aware Components:**
- **Tmux:** Auto-detects theme and uses Catppuccin `latte` (light) or `macchiato` (dark)
- **Nvim:** Uses Catppuccin with `flavour = "auto"` for automatic detection
- **Ghostty:** Uses Catppuccin themes configured as `light:Latte, dark:Macchiato`
- **Starship:** Uses `bracketed-segments` preset with system colors (no theme-specific palette)

**Syncing Themes:**
Run `sync-theme` script to reload theme across components when system theme changes:
```bash
sync-theme
```
This will reload tmux config and regenerate shell prompt. Nvim and Ghostty auto-detect on next load.
