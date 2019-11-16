{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      ale
      vim-sort-motion
      base16-vim
      vim-hindent
      vim-gitgutter
      vim-indexed-search
      auto-pairs
      fzf-vim
      emmet-vim
      vim-polyglot
      vim-polyglot
      vim-abolish
      vim-commentary
      vim-fugitive
      vim-repeat
      vim-sensible
      vim-sleuth
      vim-surround
      vim-unimpaired
      vim-vinegar
    ];

    extraConfig = builtins.readFile ./vimrc;
  };
}
