# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.rd/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Disable Oh My Zsh theme (using starship instead)
ZSH_THEME=""

# Load colors
autoload -U colors && colors

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  fast-syntax-highlighting
  fzf
)


source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

#############
### ALIAS ###
#############

alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


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

eval "$(zoxide init zsh)"

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
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
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

if [[ $(uname) == "Darwin" ]]; then
  source ~/.sdkman/bin/sdkman-init.sh
fi
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

################
### STARSHIP ###
################

eval "$(starship init zsh)"

