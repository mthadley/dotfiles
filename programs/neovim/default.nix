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
      ZIMILAR_ZORT_PATH = '${pkgs.zimilar-zort}/bin/zimilar-zort'

      require 'mthadley'
    '';
  };

  home.file.".config/nvim/lua" = {
    recursive = true;
    source = ./lua;
  };
}
