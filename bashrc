#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

PS1='[\u@\h \W]\$ '

case ${TERM} in
Eterm* | alacritty* | aterm* | foot* | gnome* | konsole* | kterm* | putty* | rxvt* | tmux* | xterm*)
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

# set -o vi
#
# set show-mode-in-prompt on
# set vi-ins-mode-string \1\e[6 q\2
# set vi-cmd-mode-string \1\e[2 q\2

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias rd='rm -fr'
alias music='mocp'
alias tmux="TERM=xterm-256color tmux"
alias ytvideo='yt-dlp -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" --embed-metadata --concurrent-fragments 30 -o "%(playlist)s/%(title)s.%(ext)s"'
alias ytshort='yt-dlp -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" --embed-metadata --concurrent-fragments 16 --recode-video mp4 -o "%(playlist)s/%(title)s.%(ext)s"'
alias ytmusic='yt-dlp -x --audio-format mp3 --audio-quality 0 -o "%(playlist)s/%(title)s.%(ext)s"'

alias extractgz='tar -xzvf'

fzf_reverse_i_search() {
	local selected_command=$(history | fzf --tac --sync -e +s --tac | sed 's/ *[0-9]* *//')
	READLINE_LINE=$selected_command
	READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\C-r": fzf_reverse_i_search'

# Use fzf to change directories
cdf() {
	local dir
	dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2>/dev/null | fzf +m) && cd "$dir"
}
bind -x '"\C-f": cdf'

conv4wp() {
	ffmpeg -i "$1" -c:v libx264 -profile:v baseline -level 3.0 -pix_fmt yuv420p "$2"
}

cdc() {
	local dir
	# Use find and fzf to select a directory
	dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2>/dev/null | fzf +m) &&
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

export TERM=xterm-256color
export EDITOR='nvim'
export BAT_THEME=Dracula

eval "$(starship init bash)"
