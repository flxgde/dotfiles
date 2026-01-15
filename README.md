# flxg Dotfiles

This repository contains my personal configuration files for a clean and customized desktop environment. It includes configurations for Zsh, Neovim, Hyprland, Ghostty, Waybar, Wofi, Tmux, and custom scripts.

---

## Features

- **Shell:** Zsh with plugins for autosuggestions, syntax highlighting, and fast syntax highlighting.
- **Prompt:** Starship with `bracketed-segments` preset for a clean, minimal prompt.
- **Window Manager:** Hyprland with custom workspace and theme configuration.
- **Editor:** Neovim with modular Lua configuration, plugin management, and LSP support.
- **Terminal:** Ghostty with personalized settings and auto-detecting Catppuccin theme.
- **Status Bar:** Waybar with scripts for updates and system monitoring.
- **Launcher:** Wofi with custom styling.
- **Tmux:** Tmux with tpm (Tmux Plugin Manager), Catppuccin theme that auto-detects system light/dark preference.
- **Scripts:** Custom binaries in `.local/bin` for workflow utilities and theme management.
- **Theme System:** Automatic light/dark theme detection across all components with `sync-theme` utility.

---

## Installation

1. **Clone the repository:**

```bash
git clone https://github.com/flxg/dotfiles.git ~/dotfiles


2. **Create symlinks for configuration files:**

ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim
ln -sf ~/dotfiles/.config/hypr ~/.config/hypr
ln -sf ~/dotfiles/.config/ghostty ~/.config/ghostty
ln -sf ~/dotfiles/.config/tmux ~/.config/tmux
ln -sf ~/dotfiles/.config/waybar ~/.config/waybar
ln -sf ~/dotfiles/.config/wofi ~/.config/wofi

3. **Make scripts executable:**

chmod +x ~/.local/bin/*

4. **Set Zsh as the default shell (optional):**

chsh -s /usr/bin/zsh

---

## Theme Management

All components support automatic light/dark theme detection:

**To sync themes when system theme changes:**
```bash
sync-theme
```

This script reloads:
- **Tmux** configuration with theme-aware Catppuccin flavor
- **Zsh** shell environment

Components that auto-detect on next load:
- **Neovim** - Catppuccin with `flavour = "auto"`
- **Ghostty** - Configured with both light and dark themes
- **Starship** - Uses system colors (preset-based, no palette switching)

