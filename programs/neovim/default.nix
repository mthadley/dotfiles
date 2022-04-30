{ pkgs, ... }:

let
  vim-fzf-builtin = pkgs.vimUtils.buildVimPlugin {
    name = "vim-fzf-builtin";
    src = "${pkgs.fzf}/share/vim-plugins/fzf";
  };

  fzfVimPreview = "${pkgs.vimPlugins.fzf-vim}/bin/preview.sh";
in
{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      auto-pairs
      base16-vim
      gitsigns-nvim
      neoformat
      nvim-lspconfig
      tslime
      vim-abolish
      vim-commentary
      vim-fugitive
      vim-fzf-builtin
      vim-indent-object
      vim-polyglot
      vim-rails
      vim-repeat
      vim-sort-motion
      vim-surround
      vim-test
      vim-unimpaired
      vim-vinegar
    ];

    extraConfig = ''
      " au commands

      "" Autoreload file on change
      set autoread
      au CursorHold * checktime

      "" Remove trailing whitespace
      au BufWritePre * :%s/\s\+$//e

      lua <<LUA
        FZF_VIM_PREVIEW_PATH = '${fzfVimPreview}'
        RIPGREP_PATH = '${pkgs.ripgrep}/bin/rg'
        SIMILAR_SORT_PATH = '${pkgs.similar-sort}/bin/similar-sort'

        require 'mthadley.init'
      LUA
    '';
  };

  home.file.".config/nvim/lua" = {
    recursive = true;
    source = ./lua;
  };

  home.file.".config/nvim/autoload/neoformat/formatters/purescript.vim".text = ''
    function! neoformat#formatters#purescript#enabled() abort
        return ['purty']
    endfunction

    function! neoformat#formatters#purescript#purty() abort
        return {
            \ 'exe': 'purty',
            \ 'args': ['-'],
            \ 'stdin': 1
            \ }
    endfunction
  '';
}
