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
alias ls='lsd --color=auto --group-dirs=first --icon=always'
alias ll='lsd -l --group-dirs=first --icon=always'
alias la='lsd -a --group-dirs=first --icon=always'
alias l='lsd --group-dirs=first --icon=always --classify'
alias mkdir='mkdir -p'
alias reload='source ~/.zshrc'
alias grep='grep --color=auto'
alias rd='rm -fr'
alias music='mocp'
# alias tmux='TERM=xterm-256color tmux'
alias ytvideo='noglob yt-dlp -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" --embed-metadata --concurrent-fragments 30 -o "%(playlist)s/%(title)s.%(ext)s"'
alias ytmusic='noglob yt-dlp -x --audio-format mp3 --audio-quality 0 --embed-metadata --ignore-errors --no-overwrites -o "%(playlist)s/%(title)s.%(ext)s"'
alias extractgz='tar -xzvf'
alias ta='tmux attach -t'                  # Attach new tmux session to already running named session
alias tl='tmux list-sessions'              # Displays a list of running tmux sessions
# alias tmux='tmux new-session'              # Start a new tmux session
alias tn='tmux new-session'             # Create a new named tmux session
alias ts='tmux new-session -s'             # Create a new named tmux session
alias tkss='tmux kill-session -t'          # Terminate named running tmux session
alias tksv='tmux kill-server'              # Terminate all running tmux sessions


# History settings
HISTSIZE=10000
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
bindkey '^F' fzf-cd-widget
bindkey '^[' vi-cmd-mode
bindkey -s '^N' 'nvim\n'

# Convert video for web
conv4wp() {
    input_file="$1"
    output_file="${input_file%.*}.mp4"
    ffmpeg -i "$input_file" -c:v libx264 -profile:v baseline -level 3.0 -pix_fmt yuv420p -threads 0 "$output_file"
}

extract() {
    if [ -z "$1" ]; then
        echo "Usage: extract <file>"
        return 1
    elif [ ! -f "$1" ]; then
        echo "'$1' is not a valid file."
        return 1
    fi
    FILENAME=$(basename "$1")
    DEST_DIR="${FILENAME%.*.*}"
    mkdir -p "$DEST_DIR"
    case "$1" in
        *.tar.gz|*.tgz) pv "$1" | tar -xzf - -C "$DEST_DIR" ;;
        *.tar.bz2) pv "$1" | tar -xjf - -C "$DEST_DIR" ;;
        *.tar.xz) pv "$1" | tar -xJf - -C "$DEST_DIR" ;;
        *.tar) pv "$1" | tar -xf - -C "$DEST_DIR" ;;
        *.gz) gunzip -c "$1" > "$DEST_DIR/${FILENAME%.gz}" ;;
        *.bz2) bunzip2 -c "$1" > "$DEST_DIR/${FILENAME%.bz2}" ;;
        *.xz) unxz -c "$1" > "$DEST_DIR/${FILENAME%.xz}" ;;
        *.zip) unzip "$1" -d "$DEST_DIR" ;;
        *.7z) 7z x "$1" -o"$DEST_DIR" ;;
        *.rar) unrar x "$1" "$DEST_DIR" ;;
        # *.zst) unzstd -c "$1" > "$DEST_DIR/${FILENAME%.zst}" ;;
        # *.lz4) unlz4 -c "$1" > "$DEST_DIR/${FILENAME%.lz4}" ;;
        # *.lzma) unlzma -c "$1" > "$DEST_DIR/${FILENAME%.lzma}" ;;
        *) echo "Unsupported file format: '$1'"; return 1 ;;
    esac
}

# Shell integration
eval "$(fzf --zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export TERM=xterm-256color
export EDITOR='nvim'
export BAT_THEME='Dracula'
export TERMINAL='alacritty'
