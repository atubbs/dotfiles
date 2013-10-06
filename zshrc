export EDITOR="vim"

autoload -U compinit promptinit
compinit
promptinit

bindirs=("$HOME/scripts" "$HOME/local/bin" "$HOME/.local/bin")
for p in $bindirs; do
  PATH="$p:$PATH"
done
export PATH

export TERM="screen-256color"

# used by the git prompt thing
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1

# these things are handy I guess
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.git-prompt.sh
source $HOME/.keychain.sh

# unique prompt hostname color by checksum plus other prompt decor
if [[ $TERM =~ "256color" ]]; then
  host_color="38;5;$((16 + $(hostname | cksum | cut -c1-3) % 216))";
  COLOR_BAR="%{[38;5;237m%}"
  COLOR_HIST="%{[38;5;235m%}"
  COLOR_GIT="%{[38;5;242m%}"
else
  host_color="1;$((31 + $(hostname | cksum | cut -c1-3) % 6))";
  COLOR_BAR="%{[0;37m%}"
  COLOR_HIST="%{[1;30m%}"
  COLOR_GIT="%{[1;37m%}"
fi
COLOR_HOST="%{["${host_color}"m%}"
COLOR_NONE="%{[0m%}"

# git prompt, with colors, as above
precmd () { __git_ps1 "${COLOR_HOST}%m${COLOR_BAR}•${COLOR_GIT}" "${COLOR_BAR}•${COLOR_HIST}%h${COLOR_NONE} " "%s" }

# idiomatic, apparently
fpath=($HOME/.zsh $fpath)

# good old BSD, making life complicated
OS=`uname -s`
if [[ $OS =~ "Darwin" ]]; then
  alias ls="ls -G"
else
  alias ls="ls --color=auto"
fi
alias make="colormake"

alias ccat="$HOME/scripts/ccat.sh"

# well, it wasn't going to be emacs, you know
setopt vi

# better searching? who knows.
bindkey "^N" down-line-or-history
bindkey "^P" up-line-or-history
bindkey "^R" history-incremental-search-backward
