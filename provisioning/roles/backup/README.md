# backup role

Creates a timestamped tarball of everything the concern playbooks in
this directory could potentially overwrite:

- `~/.config/`
- `~/.zshrc`
- `~/.local/bin/`

Output: `~/dotfiles-backups/YYYYMMDDTHHMMSS.tar.gz`

Missing paths are skipped silently (so a fresh machine with no
`~/.zshrc` yet still works).

## Restore

```bash
tar xzf ~/dotfiles-backups/<stamp>.tar.gz -C ~
```
