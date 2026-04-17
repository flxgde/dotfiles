# Emacs keybindings (prevents vi mode, keeps Ctrl+R search)
bindkey -e

# History — per-tmux-session files
HISTDIR="${HOME}/.zsh_histories"
mkdir -p "$HISTDIR"

if [ -n "$TMUX" ]; then
  TMUX_SESSION=$(tmux display-message -p '#S' | tr -cs '[:alnum:]_-' '_')
  export HISTFILE="${HISTDIR}/history_${TMUX_SESSION}"
else
  export HISTFILE="${HISTDIR}/history_default"
fi

HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS

# Disable command hashing (recommended for mise; harmless otherwise)
set +h

# Merge command (reference):
# cat ~/.zsh_histories/history_* | sort -u > ~/.zsh_history_merged
