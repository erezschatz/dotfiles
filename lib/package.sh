
name=$(uname -a)

function pkginstall {
    for arg in $*; do
        if [[ $name =~ Ubuntu || $name =~ Debian ]]; then
	    if sudo apt-get install -y $arg; then
                return 0
            else
                return 127
            fi
        elif [[ $name =~ ARCH ]]; then
	    if sudo yaourt -Syua $arg; then
                return 0
            else
                return 127
            fi
        else
	    echo "Unknown operating system uname $name"
            return 127
        fi
    done
    return 0
}

function upgrade {
    if [[ $name =~ Ubuntu || $name =~ Debian ]]; then
	sudo apt-get update && sudo apt-get dist-upgrade
    elif [[ $name =~ ARCH ]]; then
	yaourt -Syua
    else
	echo "Unknown operating system uname $name"
    fi
}

function delete {
    for arg in $*; do
        if [[ $name =~ Ubuntu || $name =~ Debian ]]; then
	    sudo apt-get purge $arg
	    sudo apt-get autoremove --purge
        elif [[ $name =~ ARCH ]]; then
	    sudo pacman -Rsn $arg
        else
	    echo "Unknown operating system uname $name"
        fi
    done
    orphaned
}

function orphaned {
    if [[ $name =~ Ubuntu || $name =~ Debian ]]; then
	sudo deborphan
    elif [[ $name =~ ARCH ]]; then
	pacman -Qtdq
    else
	echo "Unknown operating system uname $name"
    fi
}
