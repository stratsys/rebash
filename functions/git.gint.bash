gint () {
    if [[ $1 = "help" ]]; then
        echo "Usage: gint [<feature-branch>]"
        echo "Integrate feature branch with release branch."
    else
        local current_branch=$(__rebash_git_current_branch)
        local release_branch=$(__rebash_git_relative_branch) 
        local feature_branch=${1:-$(__rebash_git_current_branch)}
        local has_feature_branch=$(git show-ref "refs/heads/$feature_branch")
        
        if [[ ! -n $has_feature_branch ]]; then
            echo "No such feature branch."
            return;        
        fi
        
        if [[ "$release_branch" == "$feature_branch" ]]; then
            echo "You're on a release branch and you didn't specificy a feature branch."
            return;
        fi

        if [[ "$current_branch" != "$release_branch" ]]; then       
            git checkout $release_branch || return # might fail if we have uncommitted changes.
        fi
        
        git pull --ff-only
        git rebase $release_branch $feature_branch
        git rebase $feature_branch $release_branch
    fi
}

#autocomplete
__git_complete gint _git_rebase