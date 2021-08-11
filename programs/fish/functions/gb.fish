function gb --description "Check out a git branch"
    set selection (
      git for-each-ref --format="%(refname:short)" --sort="-committerdate" "refs/heads" |\
      fzf \
        --header="gb - select a branch" \
        --preview="git show --no-patch --pretty=format:'%an - %s' {}" \
        --preview-window down:1
    )

    if test $status -eq 0
        git checkout $selection
    end
end
