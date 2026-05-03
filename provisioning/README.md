# provisioning

Ansible playbooks that install the apps used by this dotfiles repo and
symlink the configs into place. Split by concern — run only what you
need. Nothing here bootstraps an OS; that's Omarchy's job.

Supported OS families: `Archlinux`, `Darwin`.

## Playbooks

| Playbook       | Concern                                                          |
|----------------|------------------------------------------------------------------|
| `backup.yml`   | Tarball snapshot of ~/.config, ~/.zshrc, ~/.local/bin            |
| `shell.yml`    | zsh + oh-my-zsh + .zshrc symlink                                 |
| `tmux.yml`     | tmux + tpm + tmux.conf symlink                                   |
| `terminal.yml` | ghostty + config symlink                                         |
| `neovim.yml`   | neovim + config symlink                                          |
| `hyprland.yml` | hyprland configs (symlink-only — Omarchy installs hyprland)      |

> **Run `backup.yml` first** before any concern playbook when you're
> migrating an existing machine — concern playbooks will replace real
> config dirs with symlinks.

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
