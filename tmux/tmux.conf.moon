# Colors
#DARK=black
#LIGHT=white
# Colors for callisto
DARK=white
LIGHT=black
# Initialize environment, clean up
set -s escape-time 50

# Change to Screen's ctrl-a escape sequence
# source /usr/share/doc/tmux/examples/screen-keys.conf
# On Archlinux, this file is not under the same directory
# source /usr/share/tmux/screen-keys.conf

# Shortcuts for callisto
unbind C-b
set -g prefix ^S
bind s send-prefix


set-option -g set-titles on
set-option -g set-titles-string '#(whoami)@#H - (#S)'
# Panes
set-option -g pane-active-border-bg default
set-option -g pane-active-border-fg $LIGHT
set-option -g pane-border-fg $DARK
set-option -g display-panes-time 1000
set-option -g display-panes-colour $DARK
set-option -g display-panes-active-colour $LIGHT

# History
set-option -g history-limit 10000

# Clock
set-option -g clock-mode-colour $LIGHT
set-option -g clock-mode-style 24

# Mode
set-option -g mode-keys vi
set-option -g mode-bg $DARK
set-option -g mode-fg $LIGHT

# Windows
set-window-option -g window-status-attr default
set-window-option -g window-status-bg $DARK
set-window-option -g window-status-fg $LIGHT
set-window-option -g window-status-current-attr reverse
set-window-option -g window-status-current-bg $DARK
set-window-option -g window-status-current-fg $LIGHT
#set-window-option -g window-status-alert-bg $DARK
#set-window-option -g window-status-alert-fg $LIGHT
#set-window-option -g window-status-alert-attr bold
set-window-option -g window-status-activity-bg $DARK
set-window-option -g window-status-activity-fg $LIGHT
set-window-option -g window-status-activity-attr bold
set-window-option -g automatic-rename off
set-window-option -g aggressive-resize on
set-window-option -g monitor-activity on

## Cannot use:
##  - screen-bce, screen-256color-bce: tmux does not support bce
##  - screen-256color: vim broken without -bce
set -g default-terminal "screen-256color"
#
## The following helps with Shift-PageUp/Shift-PageDown
set -g terminal-overrides 'xterm*:smcup@:rmcup@'
#
## Must set default-command to $SHELL, in order to not source ~/.profile
## BUG: Should *not* hardcode /bin/bash here
set -g default-command $SHELL

# Status
# Base index ( start counting from 1 )
set-option -g base-index 1
set-option -g status-position bottom


set -g status-bg $DARK
set -g status-fg $LIGHT
set -g status-interval 1
set -g status-left-length 256
set -g status-right-length 256
set -g status-left ' ç '
set -g status-right '| #S:#I |  %I:%M %p'

# Message
set -g message-bg $DARK
set -g message-fg $LIGHT

