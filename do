#!/bin/bash

# Get the dotfiles directory
DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PACKS=('all' 'bash' 'vim' 'tmux' 'irssi' 'htop' 'ncmpcpp' 'xfce4' 'gitconf')
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
    $p "Usage: ./do PACK [ENV]"
    $p "This tool will link the provided dotfiles to your home directory."
    $p "Example: ./do vim"
    $p "Currently available PACKS:"
    for pack in "${PACKS[@]}"
    do
        $p "  $pack"
    done
    $p "Currently available ENV:"
    for env in "${ENVS[@]}"
    do
        $p "  $env"
    done
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
            proccess_pack 'htop'
            proccess_pack 'gitconf'
        else
            proccess_pack $PACK
        fi
    else
        local pack=$1
        $p "-- Processing $pack."
        link_pack $pack
        "prep_$pack"
        link_folders $pack
        link_files $pack
    fi
}

function link_pack() {
    if [ $# -eq 0 ]
    then
        return 1
    fi
    local $pack=$1

    if [ -d "$HOME/.$pack" ]
    then
        rm -riv "$HOME/.$pack"
    fi

    if [ ! -d "$HOME/.$pack" ]
    then
        ln -sv "$DOTFILES/$pack/" "$HOME/.$pack"
    else
        $p "Won't link $DOTFILES/$pack/ to $HOME/.$pack because the directory exists."
    fi
}

function link_files() {
    if [ $# -eq 0 ]
    then
        return 1
    fi

    local $pack=$1

    for file in "${!LINK_FILES[@]}"
    do
        if [ -f "$HOME/.$pack/$file" ]
        then
            if [ -f "$HOME/${LINK_FILES[$file]}" ]
            then
                rm -iv "$HOME/${LINK_FILES[$file]}"
            fi

            if [ ! -f "$HOME/${LINK_FILES[$file]}" ]
            then
                ln -sv "$HOME/.$pack/$file" "$HOME/${LINK_FILES[$file]}"
            else
                $p "Won't link $HOME/.$pack/$file to $HOME/${LINK_FILES[$file]} because the file exists."
            fi
        fi
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
            rm -irv "$HOME/${LINK_FOLDERS[$folder]}"
        fi

        if [ ! -d "$HOME/${LINK_FOLDERS[$folder]}" ]
        then
            ln -sv "$HOME/.$pack/$folder" "$HOME/${LINK_FOLDERS[$folder]}"
        else
            $p "Won't link $HOME/.$pack/$folder to $HOME/${LINK_FOLDERS[$folder]} because the directory exists."
        fi
    done
}

function prep_bash() {
    LINK_FILES=(["bashrc.$ENV"]=".bashrc" ["bash_aliases.$ENV"]=".bash_aliases")
    LINK_FOLDERS=(["bin"]="bin" ["completion"]=".completion")
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git
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

function prep_htop() {
    LINK_FILES=(["htoprc.$ENV"]=".config/htop/htoprc")
    LINK_FOLDERS=()
}

function prep_ncmpcpp() {
    LINK_FILES=(["config.$ENV"]=".ncmpcpp/config")
    LINK_FOLDERS=()
}

function prep_xfce4() {
    LINK_FILES=()
    LINK_FOLDERS=(["terminal"]=".config/xfce4/terminal")
}

function prep_gitconf() {
    LINK_FILES=(["gitconfig"]=".gitconfig")
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

# Linking
PACK=$1
$p "-- Using PACK $PACK."
$p "-- Using ENV $ENV."

proccess_pack
