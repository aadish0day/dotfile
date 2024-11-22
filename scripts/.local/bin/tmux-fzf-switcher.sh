#!/bin/bash

# List tmux sessions and allow user to select one with fzf
selected_session=$(tmux list-sessions -F "#{session_name}" | fzf --prompt="Select a tmux session: " --height=10 --border --layout=reverse)

# If a session was selected, switch to it
if [[ -n "$selected_session" ]]; then
  tmux switch-client -t "$selected_session"
fi

