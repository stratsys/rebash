gup () {
    if [[ $1 = help ]]; then
        echo "Usage: gup"
        echo "Update feature branche with latest commits from release branch."
    else
        local release_branch=$(__rebash_git_relative_branch) feature_branch=$(__rebash_git_current_branch)
        
        if [ "$release_branch" == "$feature_branch" ]; then
            echo "You're on a release branch."
        else
            __rebash_echo_trace "Checking out '$release_branch'."
            git checkout $release_branch || return # might fail if we have uncommitted changes.
            __rebash_echo_trace "Pulling '$release_branch'."
            git pull --ff-only 
            __rebash_echo_trace "Checking out '$feature_branch'."
            git checkout $feature_branch
            __rebash_echo_trace "Merging '$release_branch' into '$feature_branch'."
            git merge $release_branch
        fi
    fi
}