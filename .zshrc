# Lines configured by zsh-newuser-install
autoload -Uz compinit
compinit
autoload -U incremental-complete-word
zle -N incremental-complete-word
autoload -U insert-files
zle -N insert-files
autoload -U predict-on
zle -N predict-on
autoload zsh/terminfo


#-----------------------------
# Dircolors
#-----------------------------
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

# Colors.
red='\e[0;31m'
RED='\e[1;31m'
green='\e[0;32m'
GREEN='\e[1;32m'
yellow='\e[0;33m'
YELLOW='\e[1;33m'
blue='\e[0;34m'
BLUE='\e[1;34m'
purple='\e[0;35m'
PURPLE='\e[1;35m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'


# Раскладка клавиш ###########################################################################

case "${TERM}" in
    st|st-*)
        bindkey "^[[H" beginning-of-line #Home key
        bindkey "^[[4~" end-of-line #End key
        bindkey "^[[P" delete-char #Del key
        bindkey "^[[A" history-beginning-search-backward #Up Arrow
        bindkey "^[[B" history-beginning-search-forward #Down Arrow
        bindkey "^[[1;5C" forward-word # control + right arrow
        bindkey "^[[1;5D" backward-word # control + left arrow
        bindkey "^H" backward-kill-word # control + backspace
        bindkey "^[[M" kill-word # control + delete
    ;;
    rxvt*|xterm*)
        bindkey "^[[7~" beginning-of-line #Home key
        bindkey "^[[8~" end-of-line #End key
        bindkey "^[[3~" delete-char #Del key
        bindkey "^[[A" history-beginning-search-backward #Up Arrow
        bindkey "^[[B" history-beginning-search-forward #Down Arrow
        bindkey "^[Oc" forward-word # control + right arrow
        bindkey "^[Od" backward-word # control + left arrow
        bindkey "^H" backward-kill-word # control + backspace
        bindkey "^[[3^" kill-word # control + delete
    ;;

    linux)
        bindkey "^[[1~" beginning-of-line #Home key
        bindkey "^[[4~" end-of-line #End key
        bindkey "^[[3~" delete-char #Del key
        bindkey "^[[A" history-beginning-search-backward
        bindkey "^[[B" history-beginning-search-forward
    ;;

    screen|screen-*)
        bindkey "^[[1~" beginning-of-line #Home key
        bindkey "^[[4~" end-of-line #End key
        bindkey "^[[3~" delete-char #Del key
        bindkey "^[[A" history-beginning-search-backward #Up Arrow
        bindkey "^[[B" history-beginning-search-forward #Down Arrow
        bindkey "^[Oc" forward-word # control + right arrow
        bindkey "^[OC" forward-word # control + right arrow
        bindkey "^[Od" backward-word # control + left arrow
        bindkey "^[OD" backward-word # control + left arrow
        bindkey "^H" backward-kill-word # control + backspace
        bindkey "^[[3^" kill-word # control + delete
    ;;
esac

zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile
zmodload -a zsh/complist complist

# Автодополнение ################################################################################
zstyle :compinstall filename '${HOME}/.zshrc'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' completer_complete_list_oldlist_expand_ignored_match_correct_approximate_prefix
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' add_space true
zstyle ':completion:*' menu select=0
zstyle ':completion:*' old-menu false
zstyle ':completion:*' original true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle ':completion:*' word true

# Опции  #######################################################################################
HISTFILE=~/.histfile
HISTSIZE=500
SAVEHIST=50
# This is for antialiasing for qt- and gtk-apps
export QT_XFT=1
export GDK_USE_XFT=1setopt APPEND_HISTORY
# # # # # # # # # # # # # # # # # # # # # # # #
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# Keep history of `cd` as in with `pushd` and make `cd -<TAB>` work.
DIRSTACKSIZE=16
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

#############################################################################################
#PROMPT=$'%(!.%{\e[1;31m%}!.%{\e[1;32m%}#)%{\e[1;34m%}[%n@%d] : %{\e[0m%}'
RPROMPT=$'%{\e[1;34m%}[%T][%(1j.%{\e[1;31m%}%j%{\e[1;34m%}]%{\e[0m%}.%j]%{\e[0m%}'
#
over_ssh() {
    if [ -n "${SSH_CLIENT}" ]; then
        return 0
    else
        return 1
    fi
}

if over_ssh && [ -z "${TMUX}" ]; then
    prompt_is_ssh='%F{blue}[%F{red}SSH%F{blue}] '
elif over_ssh; then
    prompt_is_ssh='%F{blue}[%F{253}SSH%F{blue}] '
else
    unset prompt_is_ssh
fi

case $USER in
    root)
        PROMPT='%B%F{cyan}%m%k %(?..%F{blue}[%F{253}%?%F{blue}] )${prompt_is_ssh}%B%F{blue}%1~${git_prompt}%F{blue} %# %b%f%k'
    ;;

    *)  
        PROMPT='%B%F{blue}%n@%m%k %(?..%F{blue}[%F{253}%?%F{blue}] )${prompt_is_ssh}%B%F{cyan}%1~${git_prompt}%F{cyan} %# %b%f%k'

    ;;
esac
# Алиасы ######################################################################################
alias -g M='|more'
alias -g L='|less'
alias -g G='|grep --color'
alias -g H='|head'
alias -g T='|tail'

alias cp='nocorrect cp -i'
alias mv='nocorrect mv -i'
alias rm='nocorrect rm -i'
alias su='su -s /bin/zsh'
alias du='du -h'
alias df='df -h'
alias ls='ls -F --color=auto'
alias ll='ls -lhF --color=auto'
alias la='ls -alhF --color=auto'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'
alias cls='clear'
alias where='which'
alias conf='./configure'
alias apt-get='sudo apt-get'
alias al="grep '^alias' < ~/.zshrc"
alias q=exit
alias never='cd /usr/local/games/NeverwinterNights & ./nwn'

# Quick chmod ;-)
   alias rw-='chmod 600'
   alias rwx='chmod 700'
   alias r--='chmod 644'
   alias r-x='chmod 755'
# stolen from a ~/.bashrc (IIRC RedHat(?))
   alias ..='cd ..'
   alias ...='cd ../..'
   alias ....="cd ../../.."

# Функции #####################################################################################
case $TERM in
  termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
    precmd () {
      vcs_info
      print -Pn "\e]0;[%n@%M][%~]%#\a"
    } 
    preexec () { print -Pn "\e]0;[%n@%M][%~]%# ($1)\a" }
    ;;
  screen|screen-256color)
    precmd () { 
      vcs_info
      print -Pn "\e]83;title \"$1\"\a" 
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a" 
    }
    preexec () { 
      print -Pn "\e]83;title \"$1\"\a" 
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a" 
    }
    ;; 
esac

man() {
    if command -v vimmanpager >/dev/null 2>&1; then
        PAGER="vimmanpager" command man "$@"
    else
		env \
		    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		    LESS_TERMCAP_md=$(printf "\e[1;31m") \
		    LESS_TERMCAP_me=$(printf "\e[0m") \
		    LESS_TERMCAP_se=$(printf "\e[0m") \
		    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		    LESS_TERMCAP_ue=$(printf "\e[0m") \
		    LESS_TERMCAP_us=$(printf "\e[1;32m") \
		    #man "$@"
        	command man "$@"
    fi
}

reload () {
    exec "${SHELL}" "$@"
}

confirm() {
    local answer
    echo -ne "zsh: sure you want to run '${YELLOW}$*${NC}' [yN]? "
    read -q answer
        echo
    if [[ "${answer}" =~ ^[Yy]$ ]]; then
        command "${@}"
    else
        return 1
    fi
}

confirm_wrapper() {
    if [ "$1" = '--root' ]; then
        local as_root='true'
        shift
    fi

    local prefix=''

    if [ "${as_root}" = 'true' ] && [ "${USER}" != 'root' ]; then
        prefix="sudo"
    fi
    confirm ${prefix} "$@"
}

poweroff() { confirm_wrapper --root $0 "$@"; }
reboot() { confirm_wrapper --root $0 "$@"; }
hibernate() { confirm_wrapper --root $0 "$@"; }

startx() {
    exec =startx "$@"
}