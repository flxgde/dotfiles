# flxg Dotfiles

This repository contains my personal configuration files for a clean and customized desktop environment. It includes configurations for Zsh, Neovim, Hyprland, Ghostty, Waybar, Wofi, Tmux, and custom scripts.

---

## Features

- **Shell:** Zsh with plugins for autosuggestions, syntax highlighting, and fast syntax highlighting.  
- **Window Manager:** Hyprland with custom workspace and theme configuration.  
- **Editor:** Neovim with modular Lua configuration, plugin management, and LSP support.  
- **Terminal:** Ghostty with personalized settings.  
- **Status Bar:** Waybar with scripts for updates and system monitoring.  
- **Launcher:** Wofi with custom styling.  
- **Tmux:** Tmux configuration with helper scripts for session management.  
- **Scripts:** Custom binaries in `.local/bin` for workflow utilities.

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

