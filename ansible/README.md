# EndeavourOS Hyprland Setup with Ansible

This directory contains an **Ansible playbook** that automates my personal EndeavourOS setup from a clean installation — with no preinstalled desktop environment — into a fully customized, Hyprland-based workstation.

## What This Playbook Sets Up

- **Display Manager:** [ly](https://github.com/fairyglade/ly)
- **Window Manager:** [Hyprland](https://hyprland.org)
- **Terminal:** [Ghostty](https://ghostty.org)
- **Editor:** [Neovim](https://neovim.io)
- **Browser:** [Brave](https://brave.com)
- **Shell:** Zsh with [Oh My Zsh](https://ohmyz.sh/)
- **Containers:** Docker
- **Terminal Multiplexer:** tmux
- **Essential Tools:** git, htop, ripgrep, fd, fzf, bat, exa, zoxide
- **Custom Configurations:** Dotfiles from [flxgde/dotfiles](https://github.com/flxgde/dotfiles) for:
  - Hyprland (keybinds, workspaces, theme)
  - Waybar
  - Neovim (plugins, LSP, keymaps)
  - Ghostty (colors, fonts)
  - Zsh (aliases, shell configs)
  - tmux

## Requirements

- A **fresh installation of EndeavourOS** with **no desktop environment**
- `python` installed (required for Ansible)
- SSH access enabled (or local access)
- Internet connection

> ⚠️ This playbook assumes a clean system and may overwrite existing configuration files in `$HOME`.

## Setup Instructions

1. **Install Git & Ansible:**
   ```bash
   sudo pacman -S git ansible
   ```

2. **Clone the dotfiles repository:**
   ```bash
   git clone https://github.com/flxgde/dotfiles.git
   cd dotfiles/ansible
   ```

3. **Run the playbook** (all commands below must be run from inside `ansible/`):
   ```bash
   # Local execution
   ansible-playbook setup.yml -i inventory/self.yml

   # Or for remote machine
   ansible-playbook setup.yml -i inventory/probook.yml
   ```

4. **Run specific roles (optional):**
   ```bash
   ansible-playbook setup.yml -i inventory/self.yml --tags hyprland
   ansible-playbook setup.yml -i inventory/self.yml --tags "dotfiles,zsh"
   ```

Available tags: `base`, `zsh`, `ghostty`, `hyprland`, `neovim`, `browser`, `dotfiles`, `docker`, `tmux`, `uninstall-zen`

## Roles

| Role | Description |
|------|-------------|
| `base` | Core packages: git, zsh, yay, nerd fonts, ripgrep, fd, fzf, bat, exa |
| `zsh` | Oh My Zsh with plugins (autosuggestions, syntax-highlighting), zoxide |
| `ghostty` | Ghostty terminal emulator |
| `hyprland` | Hyprland, hyprlock, waybar, wofi, ly (uninstalls sddm/greetd if present) |
| `neovim` | Neovim editor |
| `browser` | Brave browser (AUR) |
| `dotfiles` | Clones dotfiles repo and symlinks configs |
| `docker` | Docker daemon, adds user to docker group |
| `tmux` | tmux with tpm (Tmux Plugin Manager), installs plugins, symlinks config from dotfiles |
| `uninstall-zen` | Removes zen-browser-bin |
