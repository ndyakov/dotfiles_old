
alias ..='cd ..'
alias ..2='cd ../..'

alias ll='ls -FAoh'
alias la='ls -Ah'
alias l='ls -FgGh'
alias du='du -h'
alias df='df -h'
alias free='free -h'
alias fixdate='sudo ntpdate bg.pool.ntp.org'
alias freeram='echo 3 | sudo tee /proc/sys/vm/drop_caches'

alias p="sudo"
alias q="exit"
alias c="clear"

# be nice tmux, be nice.
alias tmux="tmux -2"

# ---- Git ---- #
alias gst="git status -v"
alias gs="git status"
alias ga="git add"
alias gc="git commit -v"
alias gl="git log"
alias gd="git diff"

# ---- Applications ---- #
alias o="xdg-open"
alias af="sudo apt-fast"
alias afi="sudo apt-fast install -y"
alias afu="sudo apt-fast update && apt-fast upgrade -y"
alias t="hnb"
alias m="tmux"
alias ma="tmux attach"
