# tmux role

Installs tmux and symlinks `~/.config/tmux` to the checked-in config in
this repo.

## Supported OS families

`Archlinux`, `Debian`, `RedHat`, `Darwin`.

## What it does not do

- **No tpm** (Tmux Plugin Manager). The current `tmux.conf` doesn't use
  plugins, so nothing to install.
- **No custom scripts** like `tmux-sessionizer` — those live in
  `.local/bin/` and will be wired up by a separate local-bin role.
