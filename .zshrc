# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    z
    sudo
)

source $ZSH/oh-my-zsh.sh

# Dotfiles alias
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Editor default
export EDITOR="nvim"
export VISUAL="nvim"

# Alias umum
alias ls='ls --color=auto'
alias ll='ls -lah'
alias grep='grep --color=auto'
alias cls='clear'

# Alias Niri
alias niri-reload='niri msg action reload-config'

# History
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY