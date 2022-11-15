# source ~/.profile
# source ~/.bashrc

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" "powerlevel10k/powerlevel10k" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' mode auto

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
    pip
    mosh
    sudo
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(zoxide init zsh)"

eval $(thefuck --alias)

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
    PID=$(ps -ax | grep "ssh -N -f -L localhost:$3" | grep -v "grep" | awk '{ print $1 }')
    if [[ $PID ]]; then
        kill $PID
    fi
	if [[ $1 = 'salmunia' ]]; then
		# Listen to port $2 on the remote and forward it to the local port $3
		ssh -N -f -L localhost:"$3":localhost:"$2" $1
		# If couldn't resolve hostname, have this here because ethernet connection
		# is like going through the VPN.
		if [[ "$?" = "255" ]]; then
			nmcli con up id IFISC
			sleep 1
			ssh -N -f -L localhost:"$3":localhost:"$2" $1
		fi
	elif [[ $1 = 'dnds' ]]; then
		nmcli con up id CEU-VPN
		ssh -N -f -L localhost:"$3":localhost:"$2" $1
	elif [[ $1 = 'orangejupyter' ]]; then
		nmcli con up id kido-ifisc
		ssh -N -f -L localhost:"$3":localhost:"$2" $1
	fi
	
	if [[ "$new_tab" = true ]] ; then
        firefox -new-tab localhost:$3
    fi
}

function history-latexdiff(){
    # Make latexdiff with file $1.tex from commit hash $2 or $2 commits ago.
    rm -rf tmp/
    mkdir tmp
    bib_file=$(ls | grep .bib)
    if [[ "$2" =~ ^[0-9]+$ ]]; then
	    git --work-tree=tmp/ checkout HEAD~$2 -- $1.tex
	    git --work-tree=tmp/ checkout HEAD~$2 -- $bib_file
	else
	    git --work-tree=tmp/ checkout $2 -- $1.tex
	    git --work-tree=tmp/ checkout $2 -- $bib_file
	fi
	cp $bib_file $bib_file.original
	cat tmp/$bib_file >> $bib_file
	bibtex-tidy --quiet --duplicates=key --merge=first $bib_file
    latexdiff --disable-citation-markup tmp/$1.tex $1.tex > diff.tex
    latexmk -interaction=nonstopmode -pdf -outdir=tmp/ -f diff.tex
    mv $bib_file tmp/$bib_file
    mv $bib_file.original $bib_file
}

function file-latexdiff(){
    bib_file=$(ls | grep .bib)
    mv $bib_file $bib_file.original
    mv tmp/$bib_file $bib_file
    latexdiff --disable-citation-markup tmp/$1.tex $1.tex > diff.tex
    latexmk -interaction=nonstopmode -pdf -outdir=tmp/ -f diff.tex
    mv $bib_file tmp/$bib_file
    mv $bib_file.original $bib_file
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
__conda_setup="$('/home/thomas/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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
# <<< conda initialize <<<

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

alias gedit=gnome-text-editor


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias config='/usr/bin/git --git-dir=/home/thomas/.dotfiles/ --work-tree=/home/thomas'
