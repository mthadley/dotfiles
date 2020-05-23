{ pkgs, ... }:

{
  home.file.fishFunctions = {
    source = ./functions;
    target = ".config/fish/functions";
  };

  programs.fish = {
    enable = true;

    shellAliases = {
      # git
      gco = "git checkout";
      gd = "git diff";
      gplog = "git log --graph --pretty=format:\"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(cyan)<%an>%Creset\" --abbrev-commit --date=relative";
      gst = "git status";
      gwch = "git whatchanged -p --abbrev-commit --pretty=medium";

      # misc
      ls = "exa";
      npr = "npm run";
      rspec = "rspec --format documentation";
      tm = "tmux -2";
      tree = "exa --tree";
    };

    shellInit = ''
      # Add nix and others to path
      set -x PATH "$HOME/.cargo/bin" "$HOME/.nix-profile/bin" "$HOME/.local/bin" $PATH

      # nix
      begin
          set -l source ~/.nix-profile/etc/profile.d/nix.sh
          if [ -f $source ]
              export (echo "source $source; env" | bash | grep NIX)
          end
      end

      # autojump
      begin
          set -l autojump_path ${pkgs.autojump}/share/autojump/autojump.fish
          [ -f $autojump_path ]; and source $autojump_path
      end
    '';

    interactiveShellInit = ''
      # Disable vi cursor shapes for different modes
      function fish_vi_cursor; end
      fish_vi_key_bindings

      # Use jk to leave insert mode
      bind -M insert -m default jk backward-char force-repaint

      # fzf keybindings
      source ${pkgs.fzf}/share/fish/vendor_functions.d/fzf_key_bindings.fish
      source ${pkgs.fzf}/share/fish/vendor_conf.d/load-fzf-key-bindings.fish

      # Color scheme
      eval sh ${pkgs.base16}/share/base16/scripts/base16-ocean.sh

      # Copied from the pre 3.0.0 default fish theme
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
      set fish_color_search_match bryellow  --background=brblack
      set fish_color_selection white --bold --background=brblack
      set fish_color_status red
      set fish_color_user brgreen
      set fish_color_valid_path --underline
    '';
  };
}
