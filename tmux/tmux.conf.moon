# Colors
#BACKGROUND=black
#FOREGROUND=white
# Colors for callisto
BACKGROUND=white
FOREGROUND=black
# Initialize environment, clean up
set -s escape-time 50

# Change to Screen's ctrl-a escape sequence
# source /usr/share/doc/tmux/examples/screen-keys.conf
# On Archlinux, this file is not under the same directory
# source /usr/share/tmux/screen-keys.conf

# Shortcuts for callisto
unbind C-b
set -g prefix ^W
bind s send-prefix

# reload configuration with r
bind r source-file ~/.tmux.conf \; display "Configuration reloaded!"

# select panes with hjkl
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# resizing panes with HJKL
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# Maximize and restore a pane
unbind Up
bind Up new-window -d -n tmp \; swap-pane -s tmp.1 \; select-window -t tmp
unbind Down
bind Down last-window \; swap-pane -s tmp.1 \; kill-window -t tmp


# switch to last pane with C-q
bind -r C-q last-pane


set-option -g set-titles on
set-option -g set-titles-string '#(whoami)@#H - (#S)'
# Panes
set-option -g pane-active-border-bg default
set-option -g pane-active-border-fg $FOREGROUND
set-option -g pane-border-fg $BACKGROUND
set-option -g display-panes-time 1000
set-option -g display-panes-colour $BACKGROUND
set-option -g display-panes-active-colour $FOREGROUND

# History
set-option -g history-limit 10000

# Clock
set-option -g clock-mode-colour $FOREGROUND
set-option -g clock-mode-style 24

# Mode
set-option -g mode-keys vi
set-option -g mode-bg $BACKGROUND
set-option -g mode-fg $FOREGROUND

# Windows
set-window-option -g window-status-attr default
set-window-option -g window-status-bg $BACKGROUND
set-window-option -g window-status-fg $FOREGROUND
set-window-option -g window-status-current-attr reverse
set-window-option -g window-status-current-bg $BACKGROUND
set-window-option -g window-status-current-fg $FOREGROUND
#set-window-option -g window-status-alert-bg $BACKGROUND
#set-window-option -g window-status-alert-fg $FOREGROUND
#set-window-option -g window-status-alert-attr bold
set-window-option -g window-status-activity-bg $BACKGROUND
set-window-option -g window-status-activity-fg $FOREGROUND
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
setw -g pane-base-index 1
set-option -g status-position bottom


set -g status-bg $BACKGROUND
set -g status-fg $FOREGROUND
set -g status-interval 1
set -g status-left-length 256
set -g status-right-length 256
set -g status-left ' ç '
set -g status-right '| #S:#I |  %I:%M %p'

# Message
set -g message-bg $BACKGROUND
set -g message-fg $FOREGROUND

