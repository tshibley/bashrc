
# Setup the base bash prompt
PS1="\[\033[38;5;1m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;2m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;6m\][\w]\[$(tput sgr0)\]\[\033[38;5;15m\] "

# Add the git status to bash prompt 
COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ ! $git_status =~ "working directory clean" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_OCHRE
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch) "
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit) "
  fi
}

PS1+="\[\$(git_color)\]"        # colors git status
PS1+="\$(git_branch)"           # prints current branch
PS1+="\[$COLOR_WHITE\]\$\[$COLOR_RESET\] "   # '#' for root, else '$'

export PS1

# Hide the ZSH thing in macos
export BASH_SILENCE_DEPRECATION_WARNING=1

# Useful aliases 
alias python=python3
alias dns_cache="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias attu="ssh tshibley@attu.cs.washington.edu"
alias sync_cap="rsync -ru /Users/trevor/Workspace/gotta-captcha-em-all/* tshibley@attu.cs.washington.edu:~/gotta-captcha-em-all/"

export PATH="$PATH:/Users/trevor/Library/Python/3.7/bin"

# Bayes Commands 
alias runpretty="cd ~/Workspace/bayes/app && prettier --check \"src/**\""
alias bayesrender="cd ~/Workspace/bayes/app/packages/app && npm run start-renderer-dev"
alias bayesrun="cd ~/Workspace/bayes/app/packages/app && npm run start-main-dev"
alias appdata="cd /Users/trevorshibley/Library/Application\ Support/@bayesian/app"
alias bayespack="cd ~/Workspace/bayes/app/packages/app && npm run dist"
alias bayesdeps="cd ~/Workspace/bayes/app/packages/app && npm run install-app-deps"

#Front commands 
alias frontstaging="git push origin HEAD:tshibley/staging -f" 

newb() {
	git pull && git checkout -b "$1" && git push --set-upstream origin "$1"
}

alias gs="git status"
alias gd="git diff"
alias gb="git branch"

ga() {
	git add "$1"
}

gcm() {
	git commit -m "$1"
}

hotfix() {
	git add . && git commit -m "$1" && git pull && git push
}


if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

export CANARY_USER=tshibley
export PREPROD_USER=tshibley

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
