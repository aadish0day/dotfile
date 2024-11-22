#!/bin/bash

# Get the list of tmux sessions excluding the one that you're currently attached to
attached_session=$(tmux display-message -p '#{session_name}')
sessions=$(tmux list-sessions -F "#{session_name}" | grep -v "^$attached_session$")

# If there are sessions available, allow the user to select one
if [[ -n "$sessions" ]]; then
  selected_session=$(echo "$sessions" | fzf --prompt="Select a tmux session: " --height=10 --border --layout=reverse)

  # If a session was selected, switch to it
  if [[ -n "$selected_session" ]]; then
    tmux switch-client -t "$selected_session"
  fi
else
  echo "No available sessions to attach."
fi

