# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


function jptt(){
	# Treat options
	new_tab=false
	local OPTIND OPTARG
	while getopts ":n" option; do
       case $option in
          n ) # Open the tab in firefox
             new_tab=true
             ;;
       esac
    done
    shift $((OPTIND -1))
    
    # Close any previous SSH tunnel to the port we wish to use.
	kill $(ps -ax | grep "ssh -N -f -L localhost:$3" | awk '{ print $1 }')
	if [ $1 == 'salmunia' ]; then
		# Listen to port $2 on the remote and forward it to the local port $3
		ssh -N -f -L localhost:$3:localhost:$2 $1
		# If couldn't resolve hostname, have this here because ethernet connection
		# is like going through the VPN.
		if [ "$?" = "255" ]; then
			nmcli con up id IFISC
			sleep 1
			ssh -N -f -L localhost:$3:localhost:$2 $1
		fi
	elif [ $1 == 'dnds' ]; then
		nmcli con up id CEU-VPN
		ssh -N -f -L localhost:$3:localhost:$2 $1
	elif [ $1 == 'orangejupyter' ]; then
		nmcli con up id kido-ifisc
		ssh -N -f -L localhost:$3:localhost:$2 $1
	fi
	
	if [ "$new_tab" = true ] ; then
        firefox -new-tab localhost:$3
    fi
}

function history-latexdiff(){
    # Make latexdiff with file $1.tex from $2 commits ago.
    mkdir tmp
    if [[ "$2" =~ ^[0-9]+$ ]]; then
	    git --work-tree=tmp/ checkout HEAD~$2 -- $1.tex
	else
	    git --work-tree=tmp/ checkout $2 -- $1.tex
	fi
    latexdiff tmp/$1.tex $1.tex > diff.tex
    latexmk diff.tex -interaction=nonstopmode -pdf -outdir=tmp/
}

function pdf-to-png(){
    for file in *; do
        extension="${file##*.}"
        filename="${file%.*}"
        if [ -f "$file" ] && [ $extension == 'pdf' ] ; then
            gs -dSAFER -dEPSCrop -r$1 -sDEVICE=png16m -o "$filename".png "$filename".pdf
        fi 
    done
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/thomas/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/thomas/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/thomas/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/thomas/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/thomas/miniconda3/etc/profile.d/mamba.sh" ]; then
    . "/home/thomas/miniconda3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# TOEDIT whenever texlive is updated
export PATH="/usr/local/texlive/2022/bin/x86_64-linux:$PATH"

eval "$(thefuck --alias)"

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

. "$HOME/.cargo/env"
