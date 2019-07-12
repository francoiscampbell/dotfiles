export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(
  git
  docker
  aws
)

source $ZSH/oh-my-zsh.sh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias sz='subl ~/.zshrc ~/.private.zshrc'
alias ssz='source ~/.zshrc'

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

export PATH=$HOME/.rbenv/shims:$PATH
rbenv() {
  unset rbenv 
  eval "$(/usr/local/bin/rbenv init -)"
  rbenv "$@"
}

export PATH=$HOME/.pyenv/shims:$PATH
pyenv() {
  unset pyenv
  eval "$(/usr/local/bin/pyenv init -)"
  pyenv "$@"
}

export PATH="$HOME/.cargo/bin:$PATH"

export GROOVY_HOME=/usr/local/opt/groovy/libexec

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# From https://github.com/jiansoung/issues-list/issues/13
# For compilers to find zlib you may need to set:
export LDFLAGS="${LDFLAGS} -L/usr/local/opt/zlib/lib -L/usr/local/opt/sqlite/lib"
export CPPFLAGS="${CPPFLAGS} -I/usr/local/opt/zlib/include -I/usr/local/opt/sqlite/include"

# For pkg-config to find zlib you may need to set:
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} /usr/local/opt/zlib/lib/pkgconfig"



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
alias cat='bat'

alias doco='docker-compose'
alias drb='docker run --rm -it --entrypoint bash'

alias vv='. .venv/bin/activate'
alias vv3='. .venv3/bin/activate'
alias ma='$(make activate)'
alias ip='ipython'
alias ip2='ipython2'
alias ip3='ipython3'

alias tf='terraform'
alias tfi='tf init'
alias tfp='tf plan'
alias tfpp='tf plan -var-file=terraform.prod.tfvars'
alias tfps='tf plan -var-file=terraform.staging.tfvars'
alias tfpd='tf plan -var-file=terraform.dev.tfvars'
alias tfa='tf apply'
alias tfap='tf apply -var-file=terraform.prod.tfvars'
alias tfas='tf apply -var-file=terraform.staging.tfvars'
alias tfad='tf apply -var-file=terraform.dev.tfvars'

alias gbc="git remote prune origin && (git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | xargs git branch -D)"
alias grp="git rev-parse"
gcopr() {
  git fetch origin pull/$1/head && git checkout FETCH_HEAD
}
gcap() {
  git commit -am "$1" && git push
}

crhtml() {
  FILE="/tmp/crhtml-${RANDOM}.html"
  >${FILE}
  open ${FILE}
}

darken_slack() {
  killall Slack
  curl -o /tmp/ssb-interop.js.zip http://neckcode.com/slack/ssb-interop.js.zip
  unzip -p /tmp/ssb-interop.js.zip ssb-interop.js > /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js
  open "/Applications/Slack.app"
}



# Include private stuff

[ -f ~/.private.zshrc ] && source ~/.private.zshrc
