# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
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
alias ytmusic='noglob yt-dlp -x --audio-format mp3 --audio-quality 0 -o "%(playlist)s/%(title)s.%(ext)s"'
alias extractgz='tar -xzvf'
alias lf='lf-ueberzug'

# History
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
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^F' cdf
bindkey '^[' vi-cmd-mode

# Use fzf to change directories
cdf() {
    local dir
    dir=$(find "${1:-.}" -path '*/\.*' -prune -o -type d -print 2>/dev/null | fzf +m)
    if [[ -n $dir ]]; then
        cd "$dir"
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
    fi

    local file="$1"
    local dest="${file%.*}"

    if [ ! -f "$file" ]; then
        echo "'$file' is not a valid file."
        return 1
    fi

    mkdir -p "$dest"
    case "$file" in
        *.tar.gz|*.tgz) tar -xvzf "$file" -C "$dest" ;;
        *.tar.bz2) tar -xvjf "$file" -C "$dest" ;;
        *.tar.xz) tar -xvJf "$file" -C "$dest" ;;
        *.tar) tar -xvf "$file" -C "$dest" ;;
        *.gz) gunzip -c "$file" > "$dest/$(basename "${file%.gz}")" ;;
        *.bz2) bunzip2 -c "$file" > "$dest/$(basename "${file%.bz2}")" ;;
        *.xz) unxz -c "$file" > "$dest/$(basename "${file%.xz}")" ;;
        *.zip) unzip -d "$dest" "$file" ;;
        *.7z) 7z x "$file" -o"$dest" ;;
        *.rar) unrar x "$file" "$dest" ;;
        *.zst) unzstd -c "$file" > "$dest/$(basename "${file%.zst}")" ;;
        *.lz4) unlz4 -c "$file" > "$dest/$(basename "${file%.lz4}")" ;;
        *.lzma) unlzma -c "$file" > "$dest/$(basename "${file%.lzma}")" ;;
        *) echo "Unsupported file format: '$file'"; return 1 ;;
    esac
}


# Shell integration
eval "$(fzf --zsh)"
eval "$(starship init zsh)"

export TERM=xterm-256color
export EDITOR='nvim'
export BAT_THEME='Dracula'


