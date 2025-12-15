gup () {
    if [[ $1 = help ]]; then
        echo "Usage: gup"
        echo "Update feature branche with latest commits from origin master branch."
    else
        local release_branch=$(__rebash_git_relative_branch) feature_branch=$(__rebash_git_current_branch)
        
        if [ "$release_branch" == "$feature_branch" ]; then
            echo "You're on a master branch."
        else
            __rebash_echo_trace "Fetching latest from origin '$release_branch'."
            git fetch origin $release_branch
            __rebash_echo_trace "Merging origin '$release_branch' into '$feature_branch'."
            git merge $release_branch
        fi
    fi
}