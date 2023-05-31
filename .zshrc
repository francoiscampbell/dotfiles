export BASH_SILENCE_DEPRECATION_WARNING=1  # allow using bash without it yelling at you

GITHUB_USERNAME='francoiscampbell'

BREW_PREFIX=$(brew --prefix)

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(
  git
  docker
  aws
)

source $ZSH/oh-my-zsh.sh

source $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

ssh-add 2> /dev/null # add SSH keys to agent

# App loading
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
rbenv() {  # Defer loading rbenv
  unset rbenv
  eval "$($BREW_PREFIX/bin/rbenv init -)"
  rbenv "$@"
}

export PATH=$HOME/.pyenv/shims:$PATH
pyenv() {  # Defer loading pyenv
  unset pyenv
  eval "$($BREW_PREFIX/bin/pyenv init -)"
  pyenv "$@"
}

export PATH="$BREW_PREFIX/opt/openjdk/bin:$PATH"

[ -f $BREW_PREFIX/etc/profile.d/autojump.sh ] && . $BREW_PREFIX/etc/profile.d/autojump.sh

# From https://github.com/jiansoung/issues-list/issues/13
# For compilers to find zlib you may need to set:
export LDFLAGS="${LDFLAGS} -L$BREW_PREFIX/opt/zlib/lib -L$BREW_PREFIX/opt/sqlite/lib -L$BREW_PREFIX/opt/openssl/lib -L$BREW_PREFIX/opt/libffi/lib"
export CPPFLAGS="${CPPFLAGS} -I$BREW_PREFIX/opt/zlib/include -I$BREW_PREFIX/opt/sqlite/include -I$BREW_PREFIX/opt/openssl/include -I$BREW_PREFIX/opt/libffi/include"

# For pkg-config to find zlib you may need to set:
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} $BREW_PREFIX/opt/zlib/lib/pkgconfig"

export GOPATH=/Users/francoiscampbell/go
export PATH="$GOPATH/bin:$PATH"

export PATH="/Users/francoiscampbell/.cargo/bin:$PATH"
export PATH="/Users/francoiscampbell/bin:$PATH"


# Functions and aliases
alias .f='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'  # https://medium.com/toutsbrasil/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b

mkcd() {
  mkdir -p $1 && cd $1
}

alias ls='exa'
alias l='exa -la'
alias cat='bat'
alias rg='rg --hidden'

alias doco='docker-compose'
alias drb='docker run --rm -it --entrypoint bash'
alias drbv='docker run --rm -it --entrypoint bash -v "$PWD:/pwd" --workdir=/pwd'
alias dmi='docker manifest inspect'
deb() {
  docker exec -it $1 bash
}

alias py='python'
alias ip='ipython'

alias mkv='py -m venv $(basename $PWD).venv'
alias v='. $(basename $PWD).venv/bin/activate'
alias mkvv='py -m venv .venv'
alias vv='. .venv/bin/activate'

alias sb='. script/bootstrap'

alias tfi='tf init'
alias tfp='tf plan'
alias tfpp='tf plan -var-file=terraform.prod.tfvars'
alias tfps='tf plan -var-file=terraform.staging.tfvars'
alias tfpd='tf plan -var-file=terraform.dev.tfvars'
alias tfpss='tf plan -var-file=terraform.shared-services.tfvars'
alias tfa='tf apply'
alias tfap='tf apply -var-file=terraform.prod.tfvars'
alias tfas='tf apply -var-file=terraform.staging.tfvars'
alias tfad='tf apply -var-file=terraform.dev.tfvars'
alias tfass='tf apply -var-file=terraform.shared-services.tfvars'
alias tfip='tf import -var-file=terraform.prod.tfvars'
alias tfis='tf import -var-file=terraform.staging.tfvars'
alias tfid='tf import -var-file=terraform.dev.tfvars'
alias tfiss='tf import -var-file=terraform.shared-services.tfvars'

alias grl="git reflog"
alias grp="git rev-parse"
alias grph="grp HEAD"
alias grpb="grp --abbrev-ref HEAD"
alias gfom="gfo \$(git_main_branch)"
alias gfod="gfo dev"
alias gmom="git merge --no-edit origin/\$(git_main_branch)"
alias gclm="gfom && gco -B \$(git_main_branch) origin/\$(git_main_branch)"
alias gcld="gfod && gco -B dev origin/dev"
alias groot="cd \$(grp --show-toplevel)"
alias grom="gcm && grhh origin/\$(git_main_branch) && gco -"
alias grbom="gfom && grb origin/\$(git_main_branch)"
alias grbomi="gfom && grb origin/\$(git_main_branch) -i"
alias grpo="git remote prune origin"
alias gskip="gc --allow-empty -m '[skip ci]' && gpf"
alias cb="grpb | pbcopy"
alias ch="grph | pbcopy"
alias gmb="git merge-base"
alias gmbm="git merge-base \$(git_main_branch) HEAD"

alias k="kubectl"
alias kg='kubectl get'
alias kd='kubectl describe'
alias tlr='tsh login --request-id'

alias safe-term='aws --no-cli-pager --no-paginate autoscaling terminate-instance-in-auto-scaling-group --no-should-decrement-desired-capacity --instance-id'

gbc() {
  gr prune origin && (gb -vv | grep '\[origin/.*: gone\]' | awk '{print $1}' | xargs git branch -D)
}
gcopr() {
  gfo pull/$1/head && git checkout FETCH_HEAD
}
gcap() {
  gc -am "$1" && gp
}


crhtml() {
  FILE="$(mktemp).html"
  >${FILE}
  open ${FILE}
}

# Include private stuff

[ -f ~/.private.zshrc ] && source ~/.private.zshrc || true

export PATH="$HOME/.local/bin:$PATH"
