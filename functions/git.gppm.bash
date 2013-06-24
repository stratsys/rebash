gppm () {
    if [[ $1 = "help" ]]; then
        echo "Usage: gppm"
        echo "Push, pull and merge several branches."
    else
        local branches current_branch previous_branch release_branches=('5.3/master' '5.4/master' '5.5/master' 'dev/master' 'vnext/master')

        __rebash_index_of release_branches[@] $(__rebash_git_current_branch)
        branches=("${release_branches[@]:$?}")
        
        if [[ ${#branches[@]} -eq 0 ]]; then
            echo "You're currently not on a release branch."
            return
        fi
        
        previous_branch=${branches[0]}
        
        __rebash_echo_trace "Pushing '$previous_branch'."
        git push origin $previous_branch || return
        
        for current_branch in "${branches[@]:1}"; do
            __rebash_echo_trace "Checking out '$current_branch'."
            git checkout $current_branch
            
            __rebash_echo_trace "Pulling '$current_branch'."
            git pull --ff-only || return
            
            __rebash_echo_trace "Merging '$previous_branch' with '$current_branch'."
            git merge --no-ff $previous_branch || return
           
            __rebash_echo_trace "Pushing '$current_branch'."
            git push origin $current_branch || return
            
            previous_branch=$current_branch        
        done
    fi
}