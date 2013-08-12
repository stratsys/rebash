go () {
    if [[ $1 = "help" ]]; then
        echo "Usage: go [<mainbranch> <featurebranch>]"
        echo "Rebases and pushes. If no <featurebranch> then pull --rebase performed on <mainbranch>"
    else
        [ -z "$1" ] && go $(__rebash_git_current_branch)
        if [[ -z $2 ]]; then
          git pull --rebase origin $1 && gpo $1
        else
          rb $1 $2 && gpo $1
        fi               
    fi
}

#autocomplete
__git_complete go _git_merge