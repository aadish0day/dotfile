#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

PS1='[\u@\h \W]\$ '

case ${TERM} in
  Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|tmux*|xterm*)
    PROMPT_COMMAND+=('printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')

    ;;
  screen*)
    PROMPT_COMMAND+=('printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')
    ;;
esac

if [[ -r /usr/share/bash-completion/bash_completion ]]; then
  . /usr/share/bash-completion/bash_completion
fi
stty susp undef
stty -ixon

alias reload='source ~/.bashrc'
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias rd='rm -fr'
alias music='mocp'
alias ytvideo='yt-dlp -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" --embed-metadata --concurrent-fragments 30 -o "%(playlist)s/%(title)s.%(ext)s"'
alias ytshort='yt-dlp -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" --embed-metadata --concurrent-fragments 16 --recode-video mp4 -o "%(playlist)s/%(title)s.%(ext)s"'




# Use fzf to change directories
cdf() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) && cd "$dir"
}

conv4wp() {
    ffmpeg -i "$1" -c:v libx264 -profile:v baseline -level 3.0 -pix_fmt yuv420p "$2"
}

cdc() {
  local dir
  # Use find and fzf to select a directory
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) && \
  if [ -n "$dir" ]; then # Proceed only if $dir is not empty
    # Change directory
    cd "$dir" || return # return in case cd fails
    # Start a new tmux session or attach to an existing one
    # You can customize the tmux command as per your requirements
    if ! tmux attach-session -t mysession; then
      tmux new-session -s mysession
    fi
  fi
}


eval "$(starship init bash)"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


export TERM=xterm-256color
alias tmux="TERM=xterm-256color tmux"
