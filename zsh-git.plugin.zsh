alias galias='git_list_aliases'

# git status aliases
alias gs='git status'
alias gss='git_status_short'

# git add aliases
alias g='git'
alias ga='git add'
alias gaa='git add --all'

#  git branch aliases
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbdf='git branch --delete --force'

# git clone aliases
alias gclcd='git_clone_and_cd'

# git commit aliases
alias gc='git commit -m'

# git checkout aliases
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout $(git_main_branch)'

# git fetch aliases
alias gf='git fetch'
alias gfo='git fetch origin'

# git log aliases
alias gl='git log'
alias glg='git log --graph'

# git push pull aliases
alias gp='git push'
alias gpl='git pull'

# git rm aliases
alias grm='git rm'

# Functions

function git_clone_and_cd() {

  if [[ -z $2 ]]; then

    git clone --recurse-submodules $1 && cd $(basename $1 .git)

  else

    git clone --recurse-submodules $1 $2 && cd $2

  fi

}

# List all git aliases from the README:

function git_list_aliases() {

  filename=~/.oh-my-zsh/custom/plugins/git/README.md

  from=$(grep -Fno '| **g** ' ${filename} | cut -f1 -d:)

  stop=$(grep -no '&nbsp;' ${filename} | cut -f1 -d:)

  to=$((stop - 2))



  echo '_______________________________________________________________________________

|             |                                                               |

| Alias       | Command                                                       |

|_____________|_______________________________________________________________|

|             |                                                               |'



  sed -n "${from},${to}p;${stop}q" ${filename} | # Take out table

    tr -d '*\\' |    # Remove **bold** and \ escapes

    sed 's/.$//' |   # Remove last '|' because its no longer lining up

    while read -r line ; do

      echo "${(r:78:)line}" # Pad spaces to 78 chars (zsh specific)

    done |

    sed 's/$/|/'     # Re-append final '|'



  echo '|_____________|_______________________________________________________________|'

}
# Print short status and log of latest commits:

function git_status_short() {

  if [[ -z $(git status -s) ]]; then

    echo 'Nothing to commit, working tree clean\n'

  else

    git status -s && echo ''

  fi

  git log -${1:-3} --oneline | cat

}

# Check if main exists and use instead of master:
function git_main_branch() {
  if [[ -n "$(git branch --list main)" ]]; then
  # -n: True if length of string output is non-zero
    echo main
  else
    echo master
  fi
}
