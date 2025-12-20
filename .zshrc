# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.rd/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

######################################
### 		PROMT 		   ###
######################################

# Function to get current git branch and status
git_prompt_inf() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    local status_val
    if ! git diff --quiet 2>/dev/null; then
      status_val="✗"  # uncommitted changes
    elif ! git diff --cached --quiet 2>/dev/null; then
      status_val="⚡"  # staged
    else
      status_val="✔"  # clean
    fi
    # Wrap branch in bold white brackets with spaces
    echo '%B%F{white}[%b%f%F{yellow}'"$branch $status_val"'%f%B%F{white}]%f%b '
  fi
}

# Disable Oh My Zsh theme
ZSH_THEME=""

# Load colors
autoload -U colors && colors

PROMPT='%B%F{white}[%f%b%F{green}%n%f%B%F{white}]%f%b%B%F{white}[%f%b%F{magenta}%m%B%F{white}]%f%b%B%F{white}[%f%b%F{blue}%~%f%B%F{white}]%f%b$(git_prompt_inf)%B%F{white}>%f%b '

RPROMPT='%F{yellow}%D{%H:%M:%S}%f'


# Left prompt: [username][path] >
# PROMPT='%B%F{white}[%f%b%F{green}%n%f%B%F@@@{white}]%f%b%B%F{white}[%f%b%F{blue}%~%f%B%F{white}]%f%b %B%F{magenta}>%f%b '

# Right prompt: current time HH:MM:SS in yellow
# RPROMPT='%F{yellow}%D{%H:%M:%S}%f'

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

##############
### SDKMAN ###
##############

if [[ $(uname) == "Darwin" ]]; then
  source ~/.sdkman/bin/sdkman-init.sh
fi

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

