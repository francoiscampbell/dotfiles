export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(
  git
  docker
)

source $ZSH/oh-my-zsh.sh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source ~/.bash_profile

alias sz='subl ~/.zshrc'

prompt_context() {
  
}

prompt_dir () {
    prompt_segment blue black "%?"
}

RSEGMENT_SEPARATOR="\ue0b2"
rprompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{%K{$CURRENT_BG}%F{$1}%}$RSEGMENT_SEPARATOR%{$bg%}%{$fg%} "
  else
    echo -n "%F{$1}%{%K{default}%}$RSEGMENT_SEPARATOR%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

rprompt_dir () {
  RPROMPT=$(rprompt_segment blue black '%1~ ')
}

autoload -U add-zsh-hook
add-zsh-hook precmd rprompt_dir



# App loading

export NVM_DIR="$HOME/.nvm"
nvm() {  # Defer loading NVM
  unset nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm "$@"
}

export YVM_DIR="$HOME/.yvm"
yvm() {  # Defer loading YVM
  unset yvm
  [ -r $YVM_DIR/yvm.sh ] && source $YVM_DIR/yvm.sh
  yvm "$@"
}

export PATH="$HOME/.cargo/bin:$PATH"

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(pyenv init -)"



# Functions and aliases

mkvar() {
  if [ ! -e Makefile ]; then
    (echo 'Run this in a directory with a Makefile'; exit 1)
  else
    echo 'print-%:; @echo $($*)' >> Makefile
    make print-$1
    sed -i .tmp '$d' Makefile
    rm Makefile.tmp
  fi
}

alias ls='exa'
alias l='exa -la'
alias find='fd'
alias cat='bat'

alias gbc="git remote prune origin && (git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | xargs git branch -D)"
