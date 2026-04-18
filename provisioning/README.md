# provisioning

Cross-distro Ansible playbooks for setting up a fresh machine from this
dotfiles repo. Split by concern — run only what you need.

Supported OS families: `Archlinux`, `Debian`, `RedHat`, `Darwin` (WSL is
whichever distro the WSL image ships, typically `Debian`).

## Playbooks

| Playbook     | Concern                                               | Status   |
|--------------|-------------------------------------------------------|----------|
| `backup.yml` | Tarball snapshot of ~/.config, ~/.zshrc, ~/.local/bin | active   |
| `shell.yml`  | zsh                                                   | active   |
| `tmux.yml`   | tmux (multiplexer + config)                           | active   |
| `terminal.yml` | ghostty terminal emulator                           | active   |
| `hyprland.yml` | hyprland window manager (overlay on Omarchy)        | active   |
| `neovim.yml` | neovim editor + config                                | active   |

> **Run `backup.yml` first** before any concern playbook when you're
> migrating an existing machine — concern playbooks will replace real
> config dirs with symlinks.

More will be added as the old `ansible/` directory is migrated over.

## Running

All commands below assume you're inside `provisioning/`.

```bash
# Syntax check
ansible-playbook shell.yml --syntax-check

# Dry-run, shows what would change
ansible-playbook shell.yml --check --diff

# Real run
ansible-playbook shell.yml

# Only one role via tags
ansible-playbook shell.yml --tags zsh
```

## Inventory

`inventory/local.yml` targets `localhost` with `ansible_connection: local`.
Add more inventories for remote hosts as needed.

## Prerequisites

- `ansible` installed locally.
- On macOS: Homebrew must already be installed; the shell playbook does
  not bootstrap brew.
