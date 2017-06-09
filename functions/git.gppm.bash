gppm () {
    local release_branches=(
        '6.1/master'        
        '6.2/master'
        '6.3/master'
        '6.4/master'        
        '6.5/master'        
        '6.6/master'
        'dev/test'
        'dev/master' 
        '6.7/master'
        'vnext/master'
    )

    if [[ $1 = "help" ]]; then
        echo "Usage: gppm [<branch> [<branch>]]"
        echo "Push, pull and merge several branches."
    elif [[ $1 = "branches" ]]; then
        for branch in "${release_branches[@]:0}"; do
            echo $branch
        done
    else
        local branches current_branch previous_branch
       
        if [[ -z $1 ]]; then
            __rebash_index_of release_branches[@] $(__rebash_git_current_branch)
            branches=("${release_branches[@]:$?}")
        
            if [[ ${#branches[@]} -eq 0 ]]; then
                echo "You're currently not on a release branch."
                return
            fi
        else
            branches=("$@")
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
            git merge --no-ff -X renormalize $previous_branch || return
           
            __rebash_echo_trace "Pushing '$current_branch'."
            git push origin $current_branch || return
            
            previous_branch=$current_branch        
        done
    fi
}

#autocomplete
__git_complete gppm _git_merge