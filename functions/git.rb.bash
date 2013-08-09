rb () {
    if [[ $1 = "help" ]]; then
        echo "Usage: rb <mainbranch> <featurebranch>"
        echo "Rebases <mainbranch> to <featurebranch> and then back again"
    else
        gco $1 && gpl && git rebase $1 $2 && git rebase $2 $1              
    fi
}

#autocomplete
__git_complete rb _git_merge