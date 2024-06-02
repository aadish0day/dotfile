# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Add in snippets
zinit snippet OMZP::vi-mode

# Define aliases
alias mkdir='mkdir -p'
alias reload='source ~/.zshrc'
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias rd='rm -fr'
alias music='mocp'
alias tmux='TERM=xterm-256color tmux'
alias ytvideo='noglob yt-dlp -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" --embed-metadata --concurrent-fragments 30 -o "%(playlist)s/%(title)s.%(ext)s"'
alias ytshort='noglob yt-dlp -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" --embed-metadata --concurrent-fragments 16 --recode-video mp4 -o "%(playlist)s/%(title)s.%(ext)s"'
alias ytmusic='noglob yt-dlp -x --audio-format mp3 --audio-quality 0 --embed-metadata --ignore-errors --no-overwrites -o "%(playlist)s/%(title)s.%(ext)s"'
alias extractgz='tar -xzvf'

# History settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# vi mode
bindkey -v
KEYTIMEOUT=1

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Keybindings
bindkey -e
bindkey '^w' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^F' cdf
bindkey '^[' vi-cmd-mode

# Use fzf to change directories
cdf() {
    local dir
    dir=$(find "${1:-.}" -path '*/\.*' -prune -o -type d -print 2>/dev/null | fzf +m)
    if [[ -n $dir ]]; then
        cd "$dir" || return # Ensure cd is successful
    fi
}
zle -N cdf

# Convert video for web
conv4wp() {
    ffmpeg -i "$1" -c:v libx264 -profile:v baseline -level 3.0 -pix_fmt yuv420p "$2"
}

extract() {
    if [ -z "$1" ]; then
        echo "Usage: extract <file>"
        return 1
    elif [ ! -f "$1" ]; then
        echo "'$1' is not a valid file."
        return 1
    fi

    case "$1" in
        *.tar.gz|*.tgz) tar -xzf "$1" ;;
        *.tar.bz2) tar -xjf "$1" ;;
        *.tar.xz) tar -xJf "$1" ;;
        *.tar) tar -xf "$1" ;;
        *.gz) gunzip "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.xz) unxz "$1" ;;
        *.zip) unzip "$1" ;;
        *.7z) 7z x "$1" ;;
        *.rar) unrar x "$1" ;;
        *.zst) unzstd "$1" ;;
        *.lz4) unlz4 "$1" ;;
        *.lzma) unlzma "$1" ;;
        *) echo "Unsupported file format: '$1'"; return 1 ;;
    esac
}

# Shell integration
eval "$(fzf --zsh)"
eval "$(starship init zsh)"

export TERM=xterm-256color
export EDITOR='nvim'
export BAT_THEME='Dracula'

