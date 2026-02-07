# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export PATH="$HOME/.rd/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export EDITOR='nvim'

###############
### ZINIT #####
###############

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Auto-install zinit if not present
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Essential completions (load early, but async)
zinit wait lucid for \
  atinit"autoload -Uz compinit && compinit -C" \
  zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
  zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
  zsh-users/zsh-completions

# Git plugin from OMZ (turbo loaded)
zinit wait lucid for \
  OMZL::git.zsh \
  OMZP::git

# FZF
zinit wait lucid for \
  junegunn/fzf

#############
### ALIAS ###
#############

alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Common aliases (previously from OMZ)
alias ll='ls -lh'
alias la='ls -lAh'
alias l='ls -lah'
alias lsa='ls -lah'

########################
### TMUX SESSIONIZER ###
########################

tmux-switcher-widget() {
  BUFFER="tmux-switch-session"
  zle accept-line
}
zle -N tmux-switcher-widget
bindkey '\e\e' tmux-switcher-widget

tmux-sessionizer-widget() {
  BUFFER="tmux-sessionizer"
  zle accept-line
}
zle -N tmux-sessionizer-widget
bindkey '^f' tmux-sessionizer-widget

######################
#### CONFIG RELOAD ###
######################

configreload-widget() {
  BUFFER="source ~/.zshrc"
  zle accept-line
}
zle -N configreload-widget
bindkey '\ep' configreload-widget

###############
### ZOXIDE  ###
###############

# Cached zoxide init (regenerate with: zoxide init zsh > ~/.zoxide.zsh)
if [[ -f ~/.zoxide.zsh ]]; then
  source ~/.zoxide.zsh
else
  eval "$(zoxide init zsh)"
fi

################
#### ALIASES ###
################

if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

###############
####  NVM  ####
###############

if [[ $(uname) != "Darwin" ]]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

###############
### HISTORY ###
###############

HISTDIR="${HOME}/.zsh_histories"
mkdir -p "$HISTDIR"

if [ -n "$TMUX" ]; then
  TMUX_SESSION=$(tmux display-message -p '#S' | tr -cs '[:alnum:]_-' '_')
  export HISTFILE="${HOME}/.zsh_histories/history_${TMUX_SESSION}"
else
  export HISTFILE="${HOME}/.zsh_histories/history_default"
fi

HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS

# COMMAND TO MERGE HISTORIES:
# cat ~/.zsh_histories/history_* | sort -u > ~/.zsh_history_merged

##############
### SDKMAN ###
##############

# Lazy-load SDKMAN - only initialize when needed
if [[ $(uname) == "Darwin" ]]; then
  export SDKMAN_DIR="$HOME/.sdkman"

  __sdkman_lazy_load() {
    unfunction sdk java gradle mvn kotlin groovy 2>/dev/null
    [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
  }

  sdk() { __sdkman_lazy_load && sdk "$@" }
  java() { __sdkman_lazy_load && java "$@" }
  gradle() { __sdkman_lazy_load && gradle "$@" }
  mvn() { __sdkman_lazy_load && mvn "$@" }
  kotlin() { __sdkman_lazy_load && kotlin "$@" }
  groovy() { __sdkman_lazy_load && groovy "$@" }
fi

################
### STARSHIP ###
################

# Cached starship init (regenerate with: starship init zsh > ~/.starship.zsh)
if [[ -f ~/.starship.zsh ]]; then
  source ~/.starship.zsh
else
  eval "$(starship init zsh)"
fi
