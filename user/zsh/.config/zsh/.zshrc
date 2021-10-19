#
# Sourcing Plugins
#

if [ -n "$ZGEN_DIR" ]; then
    [ -x "$ZGEN_DIR/zgen.zsh" ] || ( mkdir -p "$ZGEN_DIR" &&  git clone "https://github.com/tarjoilija/zgen" "$ZGEN_DIR" )
    source "$ZGEN_DIR/zgen.zsh"
    
    if ! zgen saved; then
        echo "Initializing zgen"

        zgen load zsh-users/zsh-autosuggestions
        zgen load zsh-users/zsh-syntax-highlighting
        zgen load popstas/zsh-command-time

        zgen save
    fi
fi

#
# Configuring Plugins
#

# Configure popstas/zsh-command-time
ZSH_COMMAND_TIME_MIN_SECONDS=5
ZSH_COMMAND_TIME_MSG="finished after %s"
ZSH_COMMAND_TIME_COLOR=14


#
# General Settings 
#

# Source aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases"


# Configure History
[ -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" ] || ( echo "Missing zsh cache directory \"${XDG_CACHE_HOME:-$HOME/.cache}/zsh\", creating..." && mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" && echo "cache directory created" )
export HISTFILE=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history
export SAVEHIST=100000          # Max capacity for HISTFILE
export HISTSIZE=100000          # Max capacity for internal history

setopt HIST_IGNORE_SPACE        # If a command starts with a space, don't write it to the HISTFILE
setopt EXTENDED_HISTORY         # Record timestamp of command in HISTFILE
setopt HIST_EXPIRE_DUPS_FIRST   # When HISTFILE exceeds max capacity, delete duplicates before truncating
setopt APPEND_HISTORY           # Append internal history to history file on shell exit
setopt SHARE_HISTORY            # Share history between sessions


#
# Enable command completion
#

autoload -Uz compinit
compinit
zmodload zsh/complist                               # Required for setting custom keys for completion navigation
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
_comp_options+=(globdots)



#
# Keybinds & related stuff
#

# Vi Mode
bindkey -v
KEYTIMEOUT=1
DEFAULT_VI_MODE=viins

bindkey -v '^?' backward-delete-char    # makes backspace behave like'd you expect it to
bindkey -v '^[[3~' vi-delete-char       # makes delete behave like'd you expect it to


# Navigate completion entries with vim keys
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char


# If fzf is installed, use embedded fzf for history search
if ([ -f "/usr/share/fzf/key-bindings.zsh" ] && [ -f "/usr/share/fzf/completion.zsh" ]); then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh

    export FZF_CTRL_R_OPTS="--layout=reverse"
else
    bindkey -M vicmd '^R' history-incremental-search-backward
    bindkey -M viins '^R' history-incremental-search-backward
fi


# Allow usage of text editor for commandline input
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line


# Open GUIFM at current position
bindkey -s '^N' '$GUIFM . \n' 


#
# Appearance
#

CURSOR_BEAM='\e[5 q'
CURSOR_BLOCK='\e[1 q'

setopt promptsubst
function build-prompt {
    local prompt
    local NEWLINE=$'\n'
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n')
    
    if [[ -n $DISPLAY ]]; then
        # non-tty prompt

        prompt="%K{12}%F{0} %~ %F{12}"
        [ -n "$branch" ] && prompt+="%K{11}%F{0}  ${branch} %F{11}"
        prompt+="%k%f${NEWLINE}%(!.#.$) "
    else
        # tty prompt

        prompt="[%n@%M]"
        [ -n "$branch" ] && prompt+=" git: ${branch}"
        prompt+=" %~${NEWLINE}%(!.#.$) "
    fi

    echo ${prompt}
}

PROMPT='$(build-prompt)'


function build-rprompt {
    local prompt
    case ${KEYMAP} in
        (vicmd) prompt="--- NORMAL ---" ;;
        (main|viins|'') prompt="--- INSERT ---" ;;
        (*) prompt="--- ? ---" ;;
    esac
    echo $prompt
}

RPROMPT='$(build-rprompt)'



#
# ZLE hooks
#

function zle-line-init {
    zle reset-prompt
    zle -R
}
zle -N zle-line-init


function zle-keymap-select {
    if [[ "$KEYMAP" == "vicmd" ]]; then
        print -n $CURSOR_BLOCK
    else
        print -n $CURSOR_BEAM
    fi

    zle reset-prompt
    zle -R
}
zle -N zle-keymap-select


function zle-line-finish {
    RPROMPT="[$( date +'%H:%M:%S')]"
    zle reset-prompt
    zle -R
    RPROMPT='$(build-rprompt)'
}
zle -N zle-line-finish


#
# precmd hooks
# 

change-title-to-pwd() {
    printf "\x1b]0;$TERM: %s\x07" "$PWD"
}

precmd_functions+=(change-title-to-pwd)

#
# preexec hooks
#

change-cursor-to-bar() {
    echo -n $CURSOR_BEAM
}

change-window-title-to-program() {
    printf "\x1b]0;$TERM: %s\x07" "$1"
}

preexec_functions+=(change-cursor-to-bar)
preexec_functions+=(change-window-title-to-program)


#
# Startup
# 

# ZSH starts in vi-insert mode, but won't change cursor until the first input
# so this is how I'm faking it
echo -n $CURSOR_BEAM
