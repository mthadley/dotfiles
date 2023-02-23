{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      base16-vim
      comment-nvim
      gitsigns-nvim
      neoformat
      nvim-autopairs
      nvim-lspconfig
      registers-nvim
      tslime
      vim-fugitive
      fzf-lua
      vim-indent-object
      vim-polyglot
      vim-rails
      vim-sort-motion
      vim-surround
      vim-test
      vim-unimpaired
      vim-vinegar
    ];

    extraLuaConfig = ''
      RIPGREP_PATH = '${pkgs.ripgrep}/bin/rg'
      SIMILAR_SORT_PATH = '${pkgs.similar-sort}/bin/similar-sort'

      require 'mthadley.init'
    '';
  };

  home.file.".config/nvim/lua" = {
    recursive = true;
    source = ./lua;
  };
}
