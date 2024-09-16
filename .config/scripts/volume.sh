usage() {
    cat <<EOF
Usage:
EOF
}

get_volume() {
    pamixer --get-volume-human
}

if [[ $# -gt 0 ]]; then
    case "$1" in
        volume)
            handle_volume "$2"
        ;;
    esac
else
    usage
fi
