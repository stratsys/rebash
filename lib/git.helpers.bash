__rebash_git_current_branch () {
    git symbolic-ref --short HEAD
}

__rebash_git_relative_branch () {
    local branch=$(__rebash_git_current_branch)
    echo ${branch/\/[0-9]*/\/master}
}