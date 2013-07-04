gmerge() {
    if [ -z "$1" ]; then
        echo "Usage: gmerge <branch> [<branch> .. [<branch>]]"
    else
        local previous_branch=$1
        
        __rebash_echo_trace "Pushing '$previous_branch'."
        git push origin $previous_branch || return
        
        # remove the first argument from function arguments
        shift
        
        # iterate function arguments
        for current_branch in "$@"; do
            __rebash_echo_trace "Checking out '$current_branch'."
            git checkout $current_branch
            
            __rebash_echo_trace "Pulling '$current_branch'."
            git pull --ff-only || return
            
            __rebash_echo_trace "Merging '$previous_branch' with '$current_branch'."
            git merge --no-ff $previous_branch || return
            
            __rebash_echo_trace "Pushing '$current_branch'."
            git push origin $current_branch || return
            
            local previous_branch=$current_branch
        done    
    fi
}