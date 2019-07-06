function gb --description 'Check out a git branch'
  set -l branch (git branch | fzf --header="gb - select a branch" | string trim)

  if [ -n $branch ]
    git checkout $branch
  end
end
