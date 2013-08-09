gogo () {
    if [[ $1 = "help" ]]; then
        echo "Usage: gogo [<mainbranch>] [<featurebranch>]"
        echo "Rebases and merges and pushes one branch at a time all the way to master). If no <featurebranch> then pull --rebase performed on <mainbranch>"
    else
        go $1 $2 && gppm
    fi
}

#autocomplete
__git_complete gogo _git_merge