#!/bin/bash

SESH="name_of_session"
PROJ1_WD="~/Documents/example_dir/example_project/"

# name session & name 0th window
tmux new-session -d -s $SESH
tmux rename-window -t $SESH:0 first_window_name

# go to working directory
tmux send-keys -t $SESH:first_window_name.0 "cd $PROJ1_WD && nvim ." C-m

# split vertically 
tmux split-window -t $SESH:first_window_name.0 -v -l10%
tmux send-keys -t $SESH:first_window_name.1 "cd $PROJ1_WD/react_app && npm run dev" C-m

# split horizontally
tmux split-window -t $SESH:first_window_name.1 -h 
tmux send-keys -t $SESH:first_window_name.2 "cd $PROJ1_WD/node_app && npm run dev" C-m

# second window
tmux new-window -t $SESH:1
tmux rename-window -t $SESH:1 second_window_name

tmux send-keys -t $SESH:second_window_name.0 "cd ~/dotfiles && nvim ." C-m

tmux attach-session






