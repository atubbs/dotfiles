export EDITOR="vim"
alias ls="ls --color=auto"
export PROMPT=$'\e[0;32m%m.%h\e[0m %% '
alias make="colormake"
export PATH="/home/atubbs/local/bin:/home/atubbs/scripts:$PATH"
setopt vi
source /home/atubbs/media/code/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
bindkey "^R" history-incremental-search-backward
bindkey "^N" down-line-or-history
bindkey "^P" up-line-or-history
alias glances="python /home/atubbs/media/code/glances/glances/glances.py -e -1"

keychain -q --nogui --agents ssh id_rsa
. ~/.keychain/`hostname`-sh
