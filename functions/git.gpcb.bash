gpcb () {
    if [[ $1 = "help" ]]; then
        echo "Usage: gpcb"
        echo "Pushes the current branch to origin."
    else
        local branch=$(__rebash_git_current_branch)
        git push origin $branch
    fi    
}