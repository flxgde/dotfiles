# ghostty role

Installs ghostty and symlinks `~/.config/ghostty` to the checked-in
config in this repo.

## Supported OS families

`Archlinux`, `Darwin`. Ghostty isn't in standard Debian/RHEL repos — add
support there if needed.

## Install notes

- **Arch**: installs from the official `extra` repo via pacman.
- **macOS**: installs via `brew install --cask ghostty`.

## Default terminal

Writes `~/.config/xdg-terminals.list` with ghostty first, alacritty as
fallback. `xdg-terminal-exec` (used by Hyprland's `Super+Return` binding
on Omarchy) then launches ghostty.

## Note on Omarchy overlap

Your dotfiles `ghostty/config` replaces Omarchy's entirely, so features
like Omarchy's dynamic theming (`config-file = ?"~/.config/omarchy/
current/theme/ghostty.conf"`) are lost on Omarchy hosts unless you add
them back to the checked-in config.
