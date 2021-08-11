function fish_mode_prompt --description "Vi mode prompt"
    if test "$fish_key_bindings" = fish_vi_key_bindings
        or test "$fish_key_bindings" = fish_hybrid_key_bindings
        switch $fish_bind_mode
            case default
                set_color --bold blue
                echo n
            case insert
                set_color --bold green
                echo i
            case replace_one
                set_color --bold red
                echo r
            case visual
                set_color --bold magenta
                echo v
        end
        set_color normal
        echo -n ' '
    end
end
