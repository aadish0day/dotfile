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

alias mkdir='mkdir -p'
alias ls='lsd --color=auto --group-dirs=first --icon=always'
alias ll='lsd -l --group-dirs=first --icon=always'
alias la='lsd -a --group-dirs=first --icon=always'
alias l='lsd --group-dirs=first --icon=always --classify'
alias grep='grep --color=auto'
alias rd='rm -fr'
alias music='mocp'
alias tmux="TERM=xterm-256color tmux"
alias ytvideo='yt-dlp -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" --embed-metadata --concurrent-fragments 30 -o "%(playlist)s/%(title)s.%(ext)s"'
alias ytshort='yt-dlp -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" --embed-metadata --concurrent-fragments 16 --recode-video mp4 -o "%(playlist)s/%(title)s.%(ext)s"'
alias ytmusic='yt-dlp -x --audio-format mp3 --audio-quality 0 --embed-metadata --ignore-errors --no-overwrites -o "%(playlist)s/%(title)s.%(ext)s"'

alias extractgz='tar -xzvf'

fzf_reverse_i_search() {
	local selected_command=$(history | fzf --tac --sync -e +s --tac | sed 's/ *[0-9]* *//')
	READLINE_LINE=$selected_command
	READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\C-r": fzf_reverse_i_search'

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

export TERM=xterm-256color
export EDITOR='nvim'
export BAT_THEME=Dracula
export PATH="$HOME/.local/bin:$PATH"

eval "$(starship init bash)"
eval "$(zoxide init bash)"
