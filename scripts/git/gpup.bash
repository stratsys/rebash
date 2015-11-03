#!/usr/bin/env bash
show_usage () {
    echo "Usage: gpup [<remote-name=origin>]"
    echo "Pushes the current branch and tracks it."
    echo ""
    echo "  -h, --help              displays this help text and exits"
    echo ""    
}

case "$1" in
    -h|--help|"help")
        show_usage
        exit
        ;;
    *)
        remote=${1:-"origin"}
        ;;
esac

current_branch=$(git symbolic-ref --short HEAD)
git branch --set-upstream "$remote" "$current_branch"