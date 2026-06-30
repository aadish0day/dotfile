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
# zsh-vi-mode config (must be before loading the plugin)
ZVM_CURSOR_STYLE_ENABLED=false
ZVM_VI_INSERT_ESCAPE_BINDKEY='^['
function zvm_after_init() {
    eval "$(fzf --zsh)"
    bindkey '^w' autosuggest-accept
    bindkey '^p' history-search-backward
    bindkey '^n' history-search-forward
    bindkey '^F' fzf-cd-widget
    bindkey -M vicmd '^F' fzf-cd-widget
}
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# Define aliases
alias ls='lsd --color=auto --group-dirs=first --icon=always -v'
alias ll='ls -l --icon=always'
alias la='ls -a --icon=always'
alias l='ls --icon=always --classify'
alias lt='ls --tree'
alias lta='ls --tree -a'
alias mkdir='mkdir -p'
alias reload='source ~/.zshrc && rehash'
alias grep='grep --color=auto'
alias music='mocp'
alias extractgz='tar -xzvf'
alias ta='tmux attach'
alias tl='tmux list-sessions'
alias tn='tmux new-session'
alias ts='tmux new-session -s'
alias tkss='tmux kill-session -t'
alias tksv='tmux kill-server'
alias n='nvim'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cp='cpg -g'
alias mv='mvg -g'
alias rm='trash'
alias ip='ip --color=auto'
alias gst='git status'
alias gss='git status --short'
alias gp='git push'
alias gl='git pull'
alias ga='git add'
alias gd='git diff'
alias tree='tree -C'

# Unalias commands
unalias zi 2>/dev/null

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

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Shell integrations
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(dircolors -b)"

export TERM=xterm-256color
export EDITOR='nvim'
export BAT_THEME='Dracula'
export PATH="$HOME/.local/bin:$PATH"
export CHROME_EXECUTABLE=/usr/bin/chromium
