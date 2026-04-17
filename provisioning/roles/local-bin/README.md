# local-bin role

Symlinks every file in `dotfiles/.local/bin/` individually into
`~/.local/bin/`. Existing files in `~/.local/bin/` not present in
dotfiles are left alone.

Included as a dependency by any playbook that needs these scripts
(e.g. `tmux.yml` uses `tmux-sessionizer`, `tmux-switch-session`).

## No OS guard

Pure file-symlink operations — works on any OS family.
