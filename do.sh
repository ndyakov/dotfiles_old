#!/bin/bash

# Get the dotfiles directory
DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PACKS=('all' 'bash' 'vim' 'tmux' 'irssi')
ENVS=('kiba' 'moon')
declare -A LINK_FOLDERS
declare -A LINK_FILES

# Default ENV is kiba - laptop
ENV='kiba'

p="echo -e"

# Declare functions

# Seach in array
# @params $1 mixed Needle
# @params $2 array Haystack
# Returns:
#       Found       - echoes 1 and returns 0
#       Not Found   - echoes 0 and returns 1
# Example: in_array $needle "${arr[@]}"
in_array() {
    local hay needle=$1
    shift
    for hay
    do
        if [[ $hay == $needle ]]
        then
            echo 1
            return 0
        fi
    done
    echo 0
    return 1
}

# Print help message
# @params $1 array Error messages
function print_help() {
    local msg
    for msg
    do
        $p $msg
    done
    $p "\nHELP"
}

function proccess_pack() {
    if [ $# -eq 0 ]
    then
        if [ $PACK == 'all' ]
        then
            proccess_pack 'bash'
            proccess_pack 'vim'
            proccess_pack 'tmux'
            proccess_pack 'irssi'
        else
            proccess_pack $PACK
        fi
    else
        local pack=$1
        $p $pack
        link_pack $pack
        "prep_$pack"
        link_folders $pack
        link_files $pack
    fi
}

function link_pack() {
    if [ -d "$HOME/.$1" ]
    then
        rm -riv "$HOME/.$1"
    fi
    ln -sv "$DOTFILES/$1/" "$HOME/.$1"
}

function link_files() {
    if [ $# -eq 0 ]
    then
        return 1
    fi
    local $pack=$1
    for file in "${!LINK_FILES[@]}"
    do
        if [ -f "$HOME/${LINK_FILES[$file]}" ]
        then
            rm -iv "$HOME/${LINK_FILES[$file]}"
        fi
        ln -sv "$HOME/.$pack/$file" "$HOME/${LINK_FILES[$file]}"
    done
}

function link_folders() {
    if [ $# -eq 0 ]
    then
        return 1
    fi

    local $pack=$1
    for folder in "${!LINK_FOLDERS[@]}"
    do
        if [ -d "$HOME/${LINK_FOLDERS[$folder]}" ]
        then
            rm -iv "$HOME/${LINK_FOLDERS[$folder]}"
        fi
        ln -sv "$HOME/.$pack/$folder" "$HOME/${LINK_FOLDERS[$folder]}"
    done
}

function prep_bash() {
    LINK_FILES=(["bashrc.$ENV"]=".bashrc" ["bash_aliases.$ENV"]=".bash_aliases")
    LINK_FOLDERS=(["bin"]="bin" ["completion"]=".completion")
}

function prep_vim() {
    git submodule init
    git submodule update
    LINK_FILES=(["vimrc"]=".vimrc")
    LINK_FOLDERS=()
}

function prep_tmux() {
    LINK_FILES=(["tmux.conf.$ENV"]=".tmux.conf")
    LINK_FOLDERS=()
}

function prep_irssi() {
    LINK_FILES=()
    LINK_FOLDERS=()
}
# Check arguments
if [ $# -eq 0 ]
then
    print_help "Wrong number of arguments!"
    exit 1
elif [ $1 == "help" ] || [ $1 == "h" ] || [ $1 == "--help" ] || [ $1 == "-h" ]
then
    print_help
    exit 0
elif [ $(in_array $1 "${PACKS[@]}") -eq 0 ]
then
    print_help "Wrong argument!" "Pack $1 not found!"
    exit 1
fi

if [ $# -eq 2 ] && [ $(in_array $2 "${ENVS[@]}") ]
then
    ENV=$2
fi

$p "Using ENV $ENV."

# Install
PACK=$1
$p $PACK

proccess_pack
