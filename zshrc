export PATH="$HOME/scripts:$PATH"
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PROMPT=$'\e[0;32m%m.%h\e[0m %% '
precmd () { __git_ps1 "%m.%h" ":%~$ " "|%s" }
fpath=($HOME/.zsh $fpath)
source $HOME/.git-prompt.sh
export EDITOR="vim"
alias ls="ls --color=auto"
alias make="colormake"
setopt vi
#export PATH="/home/atubbs/local/bin:/home/atubbs/scripts:$PATH"
#bindkey "^R" history-incremental-search-backward
#bindkey "^N" down-line-or-history
#bindkey "^P" up-line-or-history
#alias glances="python /home/atubbs/media/code/glances/glances/glances.py -e -1"

# keychain -q --nogui --agents ssh id_rsa
# . ~/.keychain/`hostname`-sh
