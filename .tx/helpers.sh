#! /bin/sh

tmux_ls() {
    tmux ls 2>/dev/null
}

tmux_attach_or_switch() {
    if [ -z "$TMUX" ]; then
        tmux attach-session -t "$1"
    else
        tmux switch-client -t "$1"
    fi
}

get_sessions() {
    tmux_ls | awk -F '[:,()]' '{print $1}'
}

get_layouts() {
    find "$SESSIONS_ROOT" -type f -name '*.layout.sh' -exec basename {} .layout.sh \;
}

is_session() {
    get_sessions | grep -qx "$1"
}

is_layout() {
    ls "$SESSIONS_ROOT" | grep -qx "$1.layout.sh"
}

usage() {
    cat <<EOF
Usage:
    -h | --help               --  show this help message
    --ls | ls                 --  show running sessions and layouts
    (--layout | -l) [layout]  --  create a new layout or edit existing one
    --preview                 --  preview session or layout
    --picker | -s             --  pick session or layout
    --sessions | -s           --  open sessionizer
    --add-sessions | -as      --  add a new directory to sessionizer
    --rm-sessions | -rs       --  remove a directory from sessionizer
    [layout]                  --  create new session from the given layout, or a blank session with the given name
    (no arguments)            --  attach to the last active session
EOF
}

example_layout() {
    cat > $2 <<EOF
. $TX_ROOT/functions.sh

# Set up project with a root dir, and name
project_root ~
session_name "$1"

# create your session
new_session

# layout your session
rename_window "code"
run_command "nvim"

new_window "servers"
split_horizontal 50%

# select the window you want first
select_window "code"

# attach to your session
attach_to_session
EOF
}

