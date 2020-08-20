if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

. $HOME/.asdf/asdf.sh

plugins=(
    git               # git aliases and utilities
)

if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

zplugin light zdharma/fast-syntax-highlighting

zplugin light zsh-users/zsh-completions
zplugin light zsh-users/zsh-autosuggestions

start_agent(){
    eval $(ssh-agent -s)
    ssh-add
}
[[ -z "${SSH_AGENT_PID}" ]] && start_agent

fpath=($HOME/.zsh/completions/ ${ASDF_DIR}/completions/ $fpath)
autoload -Uz compinit && compinit

eval $(gh completion -s zsh 2> /dev/null)

complete -C $(which aws_completer) aws 2> /dev/null

source <(kubectl completion zsh) 2> /dev/null

export GOPATH=~/go
export GOBIN=$GOPATH/bin
export GO111MODULE=on

export PATH=$PATH:$GOBIN

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(navi widget zsh)

export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_COMMAND="fd --hidden --type f"
export FZF_DEFAULT_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

cd_fzf (){
    cd $HOME && cd $(fd --hidden -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)
    clear
}

bindkey -s "^[c" "cd_fzf^M"

if [ -f /opt/shell-color-scripts/colorscript.sh ] ; then
/opt/shell-color-scripts/colorscript.sh random
fi

if [ $(command -v direnv) ] ; then
    eval "$(direnv hook zsh)"
fi

if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

alias reload='. $HOME/.zshrc'

alias new-ssh='ssh-keygen -t rsa -b 4096 -C'

alias cra='create-react-app'

alias pbcopy='xclip -selection clipboard'

alias ..='cd ..'
alias ...='cd ../..'

alias ls='exa --color=always --group-directories-first' # my preferred listing
alias la='exa -la --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing

alias cls='clear'

alias open="xdg-open"

alias d='docker'
alias dc='docker-compose'

alias emacs='LANG=pt_BR.utf8 && emacs'

alias eclj='https --download --out ./.dir-locals.el https://gist.githubusercontent.com/YuhriBernardes/3e6e8e1efadc03bcf42e16c92556cb2a/raw/200ea80fb4b54c882a455f6d0686bc71366ed5d6/.dir-locals.el'

alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias cfga='cfg add'
alias cfgs='cfg status'
alias cfgc='cfg commit -m'

vpn () {
    VPN_LOCATION="$HOME/.accesses/paygo"

    if [ $1 = office ] ;then


        sudo openfortivpn -c $VPN_LOCATION/office.conf

    elif [ $1 = kafka ]; then
        sudo openvpn \
             --config $VPN_LOCATION/kafka/kafka.ovpn \
             --cert $VPN_LOCATION/kafka/kafka.crt \
             --key $VPN_LOCATION/kafka/kafka.key \
             --auth-retry interact
    fi
}
