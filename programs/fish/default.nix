{ pkgs, ... }:

let
  fish_functions = builtins.attrNames (builtins.readDir ./functions);
  fish_function_files = builtins.map (file_name: ./functions + "/${file_name}") fish_functions;
in
{
  programs.fish = {
    enable = true;

    shellAliases = {
      ls = "exa";
      tree = "exa --tree";
      npr = "npm run";
      tm = "tmux -2";
      gd = "git diff";
      gco = "git checkout";
      gst = "git status";
      gwch = "git whatchanged -p --abbrev-commit --pretty=medium";
      gplog = "git log --graph --pretty=format:\"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(cyan)<%an>%Creset\" --abbrev-commit --date=relative";
      rspec = "rspec --format documentation";
    };

    shellInit = ''
      ${builtins.foldl' (xs: x: ''
        ${xs}
        ${builtins.readFile x}'') "" fish_function_files}

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
    '';
  };
}
