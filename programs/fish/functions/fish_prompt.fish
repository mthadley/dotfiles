function fish_prompt
  set last_status $status

  if not set -q -g __mthadley_fish_prompt_defined
    set -g __mthadley_fish_prompt_defined
    function _git_branch_name
      echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
    end

    function _is_git_dirty
      echo (git status -s --ignore-submodules=dirty ^/dev/null)
    end

    function _is_git_repo
      type -q git; or return 1
      git status -s >/dev/null ^/dev/null
    end
  end

  set yellow (set_color -o yellow)
  set red (set_color -o red)
  set blue (set_color -o blue)
  set green (set_color -o green)
  set normal (set_color normal)

  if test $last_status -eq 0
    set status_color $green
  else
    set status_color $red
  end

  set cwd $status_color (basename (prompt_pwd))

  if _is_git_repo
    set -l repo_branch $blue(_git_branch_name)
    set repo_info "$blue » $repo_branch"

    if test (_is_git_dirty)
      set -l dirty "$yellow *"
      set repo_info "$repo_info$dirty"
    end
  end

  echo -n -s $cwd $repo_info $normal ' '
end
