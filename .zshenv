
# set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/bin" ]] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/.local/bin" ]] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [[ -d "/data/bin" ]] ; then
    PATH="/data/bin:$PATH"
fi

if [[ -d "$HOME/.pixi/bin" ]] ; then
    PATH="$HOME/.pixi/bin:$PATH"
fi
