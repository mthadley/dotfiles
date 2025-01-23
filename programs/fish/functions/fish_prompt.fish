function fish_prompt
    set green (set_color --bold green)
    set normal (set_color normal)

    set cwd $green(basename (prompt_pwd))

    printf '%s%s %s' "$cwd$normal" (fish_git_prompt) $normal
end
