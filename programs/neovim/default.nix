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
      conform-nvim
      fzf-lua
      gitsigns-nvim
      nvim-autopairs
      nvim-lspconfig
      nvim-surround
      nvim-treesitter
      registers-nvim
      tslime
      vim-fugitive
      vim-indent-object
      vim-sleuth
      vim-sort-motion
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
