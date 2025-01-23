# Disable vi cursor shapes for different modes
function fish_vi_cursor
end
fish_vi_key_bindings

# Use jk to leave insert mode
bind -M insert -m default jk backward-char force-repaint

# Color scheme
# NOTE: These don't work on KDE's Konsole
if not set -q KONSOLE_PROFILE_NAME
    eval sh "$BASE_16_PATH/share/base16/scripts/base16-ocean.sh"
end

# Copied from the pre 3.0.0 default fish theme
# See https://github.com/fish-shell/fish-shell/commit/a6031c42bfdcdfdea33c35303d8c932a08b2e7a7
set fish_color_autosuggestion 555 brblack
set fish_color_cancel -r
set fish_color_command --bold
set fish_color_comment red
set fish_color_cwd green
set fish_color_cwd_root red
set fish_color_end brmagenta
set fish_color_error brred
set fish_color_escape bryellow --bold
set fish_color_history_current --bold
set fish_color_host normal
set fish_color_host_remote yellow
set fish_color_match --background=brblue
set fish_color_normal normal
set fish_color_operator bryellow
set fish_color_param cyan
set fish_color_quote yellow
set fish_color_redirection brblue
set fish_color_search_match bryellow --background=brblack
set fish_color_selection white --bold --background=brblack
set fish_color_status red
set fish_color_user brgreen
set fish_color_valid_path --underline
