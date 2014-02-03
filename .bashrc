# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)

# Alias definitions

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# checks if its running under acme/emacs
#if [ -f ~/.git_term -a $TERM != 'dumb' ]; then
#	source /usr/share/git/completion/git-prompt.sh
#	. ~/.git_term
#else
	unset PROMPT_COMMAND
	unset FCEDIT VISUAL
#fi

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# perl stuff

eval $(perl -I$HOME/.perl5/lib/perl5 -Mlocal::lib=$HOME/.perl5)


# plan9 stuff

PLAN9=$HOME/plan9 
PATH=$PATH:$PLAN9/bin

GS_FONTPATH=$PLAN9/postscript/font 

# Default font for Plan 9 programs.
font=$PLAN9/font/fixed/unicode.6x13.font


# ReRouting

if [ -f $HOME/.route.sh ]; then
	source $HOME/.route.sh
fi

BROWSER=firefox
EDITOR=E

export EDITOR BROWSER font GS_FONTPATH PLAN9 PATH
