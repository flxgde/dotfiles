# zsh role

Installs zsh + zoxide, sets the current user's shell to zsh, and symlinks
`~/.zshrc` to the checked-in one at the repo root.

## Supported OS families

`Archlinux`, `Debian`, `RedHat`, `Darwin`. The role fails early on anything else.

## What it does not do

- **No plugin manager install.** The shipped `.zshrc` auto-bootstraps
  [Zinit](https://github.com/zdharma-continuum/zinit) on first shell startup,
  which then installs plugins. Ansible stays out of this.
- **No Homebrew bootstrap** on macOS — assumes `brew` already exists.
- **No `oh-my-zsh`** — removed in favor of Zinit.

## Caveats

- `zoxide` is packaged in all supported package managers, but on older
  Debian/Ubuntu (< 22.04) it's absent from apt. On those, the role will
  fail clearly; install zoxide manually (e.g. via cargo or the upstream
  installer) and re-run.
- Shell change takes effect on next login.
