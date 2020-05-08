alias ga='git add --all'
alias gam='git commit --amend --reuse-message HEAD'

alias gb='git branch --verbose'
alias gbb='git branch'
alias gbr='git branch -avv'

alias gc='git commit --message'
alias gcc='git commit'

alias gco='git checkout'
alias gcob='git checkout -b'

__git_complete gco _git_checkout
__git_complete gcob _git_checkout

alias gl='git log --abbrev-commit --graph --format=oneline'
alias glg='git log --abbrev-commit --format=oneline | grep'
alias gll='git log'
alias glt='git log --abbrev-commit --graph --format=oneline --since=5am'

__git_complete gl _git_log
__git_complete glg _git_log
__git_complete gll _git_log

alias gm='git merge --no-ff'

__git_complete gm _git_merge

alias gp='git pull --ff-only'
alias gpr='git pull --rebase'
alias gpl='git pull --ff-only'
alias gpo='git push origin'

alias gre='git rebase'
__git_complete gre _git_rebase

alias gs='git status --short --branch'
alias gss='git status'

alias gclean='git clean -fx -d'

alias gco72='git checkout 7.2/master && gpl'
alias gco73='git checkout 7.3/master && gpl'
alias gcodevtest='git checkout dev/test && gpl'
alias gcodev='git checkout dev/master && gpl'
alias gcovn='git checkout vnext/master && gpl'
alias gcolts='git checkout lts/master && gpl'