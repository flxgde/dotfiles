# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an Ansible automation project that transforms a fresh EndeavourOS installation (with no desktop environment) into a fully configured Hyprland-based workstation. It's designed for Arch Linux/EndeavourOS and uses pacman/yay for package management.

## Commands

```bash
# Run full playbook locally
ansible-playbook setup.yml -i inventory/self.yml

# Run full playbook on remote machine
ansible-playbook setup.yml -i inventory/probook.yml

# Run specific role(s) using tags
ansible-playbook setup.yml -i inventory/self.yml --tags hyprland
ansible-playbook setup.yml -i inventory/self.yml --tags "dotfiles,zsh"

# Dry-run to see what would change
ansible-playbook setup.yml -i inventory/self.yml --check

# Verbose output for debugging
ansible-playbook setup.yml -i inventory/self.yml -vvv
```

Available tags match role names: `base`, `zsh`, `ghostty`, `hyprland`, `neovim`, `browser`, `dotfiles`, `docker`, `tmux`, `uninstall-zen`

Special tag: `cleanup` - Removes obsolete files (uses `never` tag, must be explicitly invoked):
```bash
ansible-playbook setup.yml -i inventory/self.yml --tags cleanup
```

## Architecture

**Main Playbook (`setup.yml`):** Orchestrates all roles sequentially. Targets hosts defined in inventory files.

**Roles execution order and dependencies:**
1. `base` - System packages (git, zsh, yay, fonts, ripgrep, fd, fzf, bat, exa)
2. `zsh` - Oh My Zsh with plugins (depends on base for zsh package)
3. `ghostty` - Terminal emulator
4. `hyprland` - Window manager, waybar, wofi, ly display manager (uninstalls sddm/greetd)
5. `neovim` - Editor
6. `browser` - Brave via AUR
7. `dotfiles` - Clones github.com/flxgde/dotfiles, symlinks configs for zsh, hyprland, neovim, ghostty, waybar
8. `docker` - Docker daemon, adds user to docker group
9. `tmux` - Terminal multiplexer: installs package, clones tpm (Tmux Plugin Manager), symlinks config from dotfiles, installs plugins
10. `uninstall-zen` - Removes zen-browser-bin

**Configuration Pattern:** Actual configs live in the external dotfiles repo (github.com/flxgde/dotfiles). This repo creates symlinks to those configs. Changes to configs should be made in the dotfiles repo, not here.

**Inventories:**
- `inventory/self.yml` - Local machine (localhost, connection: local)
- `inventory/probook.yml` - Remote machine at 192.168.178.59

**Privilege Escalation:** Roles use `become: true` for system-level changes (package installation, systemd) and `become: false` for user-level operations (dotfiles, shell config).

## Conventions

- Use `ansible_facts['env']['HOME']` and `ansible_facts['user_id']` instead of deprecated `ansible_env.HOME` and `ansible_user`
- AUR packages (via yay) must use `become: false` - yay should not run as root
- Check if systemd services exist before stopping/disabling them to avoid failures on clean systems
