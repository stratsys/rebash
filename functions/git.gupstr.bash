gupstr () {
    if [[ $1 = help ]]; then
        echo "Usage: gupstr [<branch>]"
        echo "Displays the remote branch, if any, for the current (or specified) local branch."
    else
        local branch=${1:-HEAD}
        git rev-parse --symbolic-full-name --abbrev-ref $branch@{upstream}
    fi
}