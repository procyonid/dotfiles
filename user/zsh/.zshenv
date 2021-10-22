export PATH=$HOME/.local/bin:$HOME/.bin:$HOME/.cargo/bin:$PATH

export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"
export READER="zathura"
export TERMINAL="alacritty"
export GUIFM="dolphin"

# use bat as colorizing pager for man
export MANPAGE="sh -c 'col -bx | bat -l man -p'"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZGEN_DIR="$XDG_DATA_HOME/zsh/zgen"
