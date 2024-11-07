function fish_prompt
    set last_status $status

    if not set -q -g __mthadley_fish_prompt_defined
        set -g __mthadley_fish_prompt_defined
        function _git_branch_name
            echo (git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
        end

        function _is_git_dirty
            echo (git status -s --ignore-submodules=dirty 2>/dev/null)
        end

        function _is_git_repo
            type -q git; or return 1
            git status -s >/dev/null 2>/dev/null
        end
    end

    set yellow (set_color -o yellow)
    set blue (set_color -o blue)
    set green (set_color -o green)
    set normal (set_color normal)

    set cwd $green (basename (prompt_pwd))

    if _is_git_repo
        set -l truncated_branch_name (string shorten --max 40 (_git_branch_name))
        set repo_info "$blue » $blue$truncated_branch_name"

        if test (_is_git_dirty)
            set -l dirty "$yellow *"
            set repo_info "$repo_info$dirty"
        end
    end

    echo -n -s $cwd $repo_info $normal ' '
end
