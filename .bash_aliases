# There are exactly eighty characters in this line, including the # at the start

# Default stuff, came with OS sometimes back, may be good for something

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# common linux tools

function les {
    if [ !$@ ]; then
        ls -alhF --color
    fi

    for i in $@; do
	if   [ -d "${i}" ]; then
	    ls -alhF --color $i
	elif [ -f "${i}" ]; then
	    less $i
	else
	    echo "${i} is not valid"
	fi
    done
}

alias ll='ls -alhF --color'

function greps {
    char=${1:0:1}
    headless=${1:1}
    term="[$char]$headless"
    ps -ef | grep "[${1:0:1}]${1:1}"
}

# possible fonts

# $PLAN9/font/pelm/unicode.8.font
#            /fixed/unicode.6x13.font
#            /fixed/unicode.7x13B.font

function acmep {
	nohup acme \
		-f $PLAN9/font/pelm/unicode.8.font \
		-m /mnt/acme -l /home/erez/acme.dump \
	>/dev/null 2>&1 &
}

function Acme {
	nohup acme \
		-f $PLAN9/font/fixed/unicode.6x13.font \
		-m /mnt/acme -l /home/erez/acme.dump \
	>/dev/null 2>&1 &
}

if [ ! -r $HOME/.samcmds ]; then
	touch $HOME/.samcmds
fi
alias Sam='nohup /home/erez/plan9/bin/sam .samcmds > /dev/null 2>&1 &'

alias dentro='firefox -app /home/erez/dev/dentro/application.ini &'

# git

function gpull {
	if [ ! -z "$1" ]; then
	    for i in $(ls $1); do
                if [ -d $1'/'$i ]; then
                    here=$(pwd)
	            cd $1'/'$i
		    pull_master_from $branch
                    cd $here
                fi
            done
	else

		pull_master_from $branch
	fi

}

function pull_master_from {
	branch=$(__git_ps1 "%s")
	if [ ! -z "$branch" ]; then
            if [ $branch != "master" ]; then
		git checkout master && git pull
		git checkout $branch
            else
                git pull
            fi
	fi
}

#perl and cpanm commands

source $HOME/dev/dotfiles/lib/perl.sh

# packages maintenance commands

source $HOME/dev/dotfiles/lib/package.sh

alias upall='upgrade; cpanupdate; gpull ~/dev/; upplan9'
