function fish_prompt
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

  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l normal (set_color normal)

  set -l cwd $cyan (basename (prompt_pwd))

  if _is_git_repo
    set -l repo_branch $red(_git_branch_name)
    set repo_info "$blue -> $repo_branch$blue"

    if test (_is_git_dirty)
      set -l dirty "$yellow *"
      set repo_info "$repo_info$dirty"
    end
  end

  echo -n -s $cwd $repo_info $normal ' '
end
