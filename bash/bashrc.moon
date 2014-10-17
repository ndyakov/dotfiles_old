if [ -f ~/.bash/bashrc.common ]; then
  source ~/.bash/bashrc.common
fi

function prompt_left() {
    echo -e "${debian_chroot:+($debian_chroot)}\$(if [[ \$? == 0 ]]; then echo \"\[$BGreen\]\342\234\223\"; else echo \"\[$BRed\]\342\234\227\"; fi) \[$BWhite\]\u@\[$BGreen\]\h\[$BWhite\] : \[$BBlue\]\w \[$BPurple\]$(__git_ps1 " (%s)")"
}

function prompt_right() {
    echo -e "\[$BWhite\][\[$BBlue\]\D{%k:%M}\[$BWhite\]]"
}

function prompt() {
    compensate=1
    PS1=$(printf "%s\n\[$BBlue\]➜ \[$Color_Off\]" "$(prompt_left)")
    PS1="$PS1"
}

if [ "$color_prompt" = yes ]; then
    PROMPT_COMMAND=prompt
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
