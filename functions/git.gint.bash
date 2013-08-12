gint () {
    if [[ $1 = help ]]; then
        echo "Usage: gint"
        echo "Integrate releaes branch, ie. rebase the latest commits of the release branch on the the feature branch."
    else
        local release_branch=${1:-$(__rebash_git_relative_branch)} feature_branch=$(__rebash_git_current_branch)
        
        if [ "$release_branch" == "$feature_branch" ]; then
            echo "You're on a release branch."
        else
            git checkout $release_branch
            git pull --ff-only
            git rebase $release_branch $feature_branch
        fi
    fi
}