
alias ..='cd ..'
alias ..2='cd ../..'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias ll='ls -FAoh'
alias la='ls -Ah'
alias l='ls -FgGh'
alias du='du -h'
alias df='df -h'
alias free='free -h'
alias fixdate='sudo ntpdate bg.pool.ntp.org'
alias freeram='echo 3 | sudo tee /proc/sys/vm/drop_caches'

alias gui='export DE=xfce;
           export BROWSER=google-chrome;
           exec ck-launch-session startx'

alias wifion='sudo modprobe rt2800pci;
              sudo modprobe rt2800lib;
              sudo iw dev wlan0 set power_save off'

alias wifioff='sudo rmmod rt2800pci;
               sudo rmmod rt2800lib'

alias disable_touchpad_while_typing='syndaemon -i 0.5 -d -K'
alias get_window_class='xprop WM_CLASS'

# ---- Screen layouts ---- #
alias shome='xrandr --output LVDS --mode 1366x768 --pos 0x1080 --rotate normal --output CRT1 --mode 1920x1080 --pos 0x0 --rotate normal --output DFP1 --off'
alias sonthego='xrandr --output LVDS --mode 1366x768 --pos 0x0 --rotate normal --output CRT1 --off --output DFP1 --off'
alias swork='xrandr --output LVDS --mode 1366x768 --pos 1280x0 --rotate normal --output CRT1 --mode 1280x960 --pos 0x0 --rotate normal --output DFP1 --off'

alias p="sudo"
alias q="exit"
alias c="clear"
alias suspend="sudo pm-suspend-hybrid"
alias hibernate="sudo pm-hibernate"
alias nap="suspend"

# be nice tmux, be nice.
alias tmux="tmux -2"

# ---- Learning paths ---- #
alias go-learn="cd /home/ndyakov/code/go/go-learn && l"
alias js-learn="cd /home/ndyakov/code/javascript/js-learn && l"
alias py-learn="cd /home/ndyakov/code/python/py-learn && l"
alias py="python3 "

# ---- Git ---- #
alias gst="git status -v"
alias gs="git status"
alias ga="git add"
alias gc="git commit -v"
alias gl="git log"
alias gd="git diff"

# ---- Applications ---- #
alias news="canto"
alias o="xdg-open"
alias af="sudo apt-fast"
alias afi="sudo apt-fast install -y"
alias afu="sudo apt-fast update && apt-fast upgrade -y"
alias t="hnb"
alias m="tmux"
alias ma="tmux attach"
alias term='xfce4-terminal'
