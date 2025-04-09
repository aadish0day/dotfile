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
alias ls='lsd --color=auto --group-dirs=first --icon=always -v'
alias ll='ls -l --icon=always'
alias la='ls -a --icon=always'
alias l='ls --icon=always --classify'
alias lt='ls --tree'
alias lta='ls --tree -a'
alias mkdir='mkdir -p'
alias reload='source ~/.zshrc'
alias grep='grep --color=auto'
alias rd='rm -fr'
alias music='mocp'
alias extractgz='tar -xzvf'
alias ta='tmux attach'                  # Attach new tmux session to already running named session
alias tl='tmux list-sessions'              # Displays a list of running tmux sessions
alias tn='tmux new-session'             # Create a new named tmux session
alias ts='tmux new-session -s'             # Create a new named tmux session
alias tkss='tmux kill-session -t'          # Terminate named running tmux session
alias tksv='tmux kill-server'              # Terminate all running tmux sessions
alias n='nvim'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cp='cp -v'
alias mv='mv -v'
alias ip='ip --color=auto'
alias gst='git status'
alias gss='git status --short'
alias gp='git push'
alias gl='git pull'
alias ga='git add'
alias gd='git diff'
alias tree='tree -C'

# alias ytvideo='noglob yt-dlp -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" --embed-metadata --concurrent-fragments 30 -o "%(playlist)s/%(title)s.%(ext)s"'
# alias ytmusic='noglob yt-dlp -x --audio-format mp3 --audio-quality 0 --embed-metadata --ignore-errors --no-overwrites -o "%(playlist)s/%(title)s.%(ext)s"'

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
# bindkey -s '^N' 'nvim\n'

# Shell integration
eval "$(fzf --zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export TERM=xterm-256color
export EDITOR='nvim'
export BAT_THEME='Dracula'
export TERMINAL='westerm'
export PATH="$HOME/.local/bin:$PATH"
export SAL_USE_VCL=gtk3
