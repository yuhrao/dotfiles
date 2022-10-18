SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

function sga {
    pkill gpg-agent
    export GPG_TTY="$(tty)"
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent
}

sga

export ZSH='/home/yuhri/.oh-my-zsh'
export ZSH_DISABLE_COMPFIX="true"
export DISABLE_UPDATE_PROMPT="true"
export CASE_SENSITIVE="true"
export HIST_STAMPS="dd/mm/yyyy"
export CASE_SENSITIVE="true"
export HIST_STAMPS="dd/mm/yyyy"

export GOPATH=~/go
export GOBIN="$GOPATH/bin"
export GO111MODULE=on

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export ZSH_COMP_DIR=$(echo '$HOME/.zsh/completions' | envsubst)

plugins=(git)

export MFA_DEVICE='arn:aws:iam::182191116428:mfa/yuhri.bernardes'

if [[ -f "$HOME/.wakatime"  ]]; then
export PATH="$PATH:$HOME/.wakatime"
export WAKATIME_API_KEY=$(cat $HOME/.wakatime_api_key)
fi

export PATH="$PATH:$HOME/.emacs.d/bin"

export PATH="$PATH:$HOME/.elixir-ls/release"

export PATH="$PATH:$GOBIN"

export PATH="$PATH:$HOME/.local/bin"

export TERM=alacritty

export EDITOR=/home/yuhri/.asdf/shims/nvim

source $ZSH/oh-my-zsh.sh

eval $(starship init zsh)

. $HOME/.asdf/asdf.sh

source ~/.zplug/init.zsh

zplug "zdharma/fast-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load --verbose

if [ -f '/usr/local/etc/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/etc/google-cloud-sdk/path.zsh.inc'; fi

_bb_tasks() {
    local matches=(`bb tasks |tail -n +3 |cut -f1 -d ' '`)
    compadd -a matches
    _files # autocomplete filenames as well
}
compdef _bb_tasks bb

if [ -d $ASDF_DIR ]; then
    fpath=($ZSH_COMP_DIR/ ${ASDF_DIR}/completions/ $fpath)
fi

autoload -Uz compinit && compinit

if [ $(command -v aws_completer) ]; then
    complete -C aws_completer aws
fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/etc/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/etc/google-cloud-sdk/completion.zsh.inc'; fi

if [ $(command -v kubectl) ]; then
    source <(kubectl completion zsh) 2> /dev/null
fi
if [ $(command -v minikube) ]; then
    source <(minikube completion zsh) 2> /dev/null
fi
if [ $(command -v helm) ]; then
    source <(helm completion zsh) 2> /dev/null
fi

if [ -f /opt/google-cloud-sdk/completion.zsh.inc ]; then
    source /opt/google-cloud-sdk/completion.zsh.inc
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_COMMAND="fd --hidden --type f"
export FZF_DEFAULT_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

if [ $(command -v neofetch) ] ; then
    neofetch
fi

if [ $(command -v direnv) ] ; then
    eval "$(asdf exec direnv hook zsh)"
fi

if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

alias k=kubectl
alias kgpa='kubectl get pods --all-namespaces'

alias ctop='TERM=xterm-256color ctop'

alias t='/usr/bin/tmux -f ~/.tmux.conf'
alias ta='t attach'
alias tas='t attach -t'
alias tl='t ls'
alias tn='t new'
alias tns='t new -t'
alias tks='t kill-session -t'

alias tm='/usr/bin/tmuxinator'
alias tms='tm start'
alias tmd='tm delete'
alias tml='tm ls'
alias tme='tm edit'
alias tmn='tm new'
alias tmp='tm implode'

alias gitkraken='gitkraken &!'

alias pbcopy='xclip -selection clipboard'

alias ls='exa -alh --color=always --group-directories-first'
alias la='exa -lah --color=always --group-directories-first'
alias l='exa -lh --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'
alias l.='exa -ah | egrep "^\."'

alias cls='clear'

alias open="xdg-open"

alias d='docker'
alias dc='docker-compose'

emacs (){
    /usr/bin/emacs $@ &!
}

alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias cfga='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add'
alias cfgs='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status'
alias cfgc='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit -m'
alias cfgp='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME push origin main'

_java_home(){
    if [ -d "$(asdf where java)/jre" ]; then
        echo "$(asdf where java)/jre"
    else
        echo "$(asdf where java)"
    fi
}
alias java_home='export JAVA_HOME="$(_java_home)"'

function emacs_prepare_go {
    echo "Installing gore"
    go get -u github.com/motemen/gore/cmd/gore
    echo "Installing gocode"
    go get -u github.com/stamblerre/gocode
    echo "Installing godoc"
    go get -u golang.org/x/tools/cmd/godoc
    echo "Installing goimports"
    go get -u golang.org/x/tools/cmd/goimports
    echo "Installing gorename"
    go get -u golang.org/x/tools/cmd/gorename
    echo "Installing guru"
    go get -u golang.org/x/tools/cmd/guru
    echo "Installing gotest/..."
    go get -u github.com/cweill/gotests/...
    echo "Installing gomodifytags"
    go get -u github.com/fatih/gomodifytags
    echo "installing gopls"
    go get golang.org/x/tools/gopls
}
