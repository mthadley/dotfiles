{ pkgs, ... }:

let
  vim-mix-format = pkgs.vimUtils.buildVimPlugin {
    name = "mix-format";
    src = pkgs.fetchFromGitHub {
      owner = "mhinz";
      repo = "vim-mix-format";
      rev = "cbb63e65a423ea63444a5d1b41e51d1fcec5f962";
      sha256 = "037fbmcj9dfj89jd2xa1xv55baqvws85xpjmypgr3kx7y183l0b7";
    };
  };

  vim-ormolu = pkgs.vimUtils.buildVimPlugin {
    name = "vim-ormolu";
    src = pkgs.fetchFromGitHub {
      owner = "sdiehl";
      repo = "vim-ormolu";
      rev = "4ae4fe11c558af33030abdeda6f2ee1f5b54da55";
      sha256 = "13yn0arxcn8ngc91lvhcqs3nl17zcdmgsw522qvqgn732cpf0ddy";
    };
  };

  vim-prettier = pkgs.vimUtils.buildVimPlugin {
    # The source contains a Makefile in the root which is only used for tests, so
    # this stops nix from trying to run it.
    dontBuild = true;

    name = "vim-prettier";
    src = pkgs.fetchFromGitHub {
      owner = "prettier";
      repo = "vim-prettier";
      rev = "0e61e4a5b55d2740aa118db91a6671dcb11307e8";
      sha256 = "0d83lx6kfpsi3d4q9wz8zwsgdn0vn16psqyngml6wspjyibh6pnf";
    };
  };

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
      ale
      auto-pairs
      base16-vim
      neoformat
      tslime
      vim-abolish
      vim-commentary
      vim-fugitive
      vim-fzf-builtin
      vim-gitgutter
      vim-indent-object
      vim-indexed-search
      vim-mix-format
      vim-ormolu
      vim-polyglot
      vim-prettier
      vim-rails
      vim-repeat
      vim-sensible
      vim-sort-motion
      vim-surround
      vim-test
      vim-unimpaired
      vim-vinegar
      vimwiki
    ];

    extraConfig = ''
      set clipboard=unnamed,unnamedplus
      set cursorline
      set expandtab
      set ignorecase
      set mouse=a
      set nobackup
      set nowritebackup
      set number
      set relativenumber
      set scrolloff=10
      set shiftround
      set shiftwidth=4
      set splitbelow
      set splitright
      set undofile
      set updatetime=100

      "" Use rg as grepprg
      set grepprg=${pkgs.ripgrep}/bin/rg\ --vimgrep

      " Plugin Settings

      "" 'w0rp/ale'
      let g:ale_lint_delay = 1000
      let g:ale_lint_on_enter = 0
      let g:ale_linters = {'haskell': ['hlint', 'hdevtools', 'hfmt']}
      let g:ale_linters_ignore = {
      \  'ruby': ['brakeman'],
      \  'elm': ['elm_ls'],
      \  'graphql': ['eslint']
      \}
      let g:ale_completion_enabled = 1
      let g:ale_completion_autoimport = 1
      let g:ale_close_preview_on_insert = 1
      set omnifunc=ale#completion#OmniFunc
      hi ALEError cterm=underline

      let g:ale_elm_ls_elm_analyse_trigger = 'never'
      let g:ale_elm_ls_executable = '${pkgs.elmPackages.elm-language-server}/bin/elm-language-server'

      "" chriskempson/base16-vim
      let g:base16colorspace=256

      "" fzf
      let g:fzf_colors = { 'border': ['fg', 'Comment'] }
      let g:fzf_action = {
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit' }

      "" mhinz/vim-mix-format
      let g:mix_format_on_save = 1

      "" christoomey/vim-sort-motion
      let g:sort_motion_flags = 'i'

      "" pangloss/vim-javascript
      let g:jsx_ext_required = 0
      let g:javascript_plugin_jsdoc = 1

      "" plasticboy/vim-markdown
      let g:vim_markdown_folding_disabled = 1
      let g:vim_markdown_fenced_languages = ['js=javascript', 'ini=dosini']

      "" Neoformat
      let g:neoformat_enabled_ruby = []
      let g:neoformat_enabled_sql = []
      let g:neoformat_enabled_yaml = []
      let g:neoformat_enabled_json = []

      "" vim-test
      let g:test#strategy = 'tslime'

      "" tslime
      let g:tslime_always_current_session = 1
      let g:tslime_always_current_window = 1

      "" vimwiki
      let g:vimwiki_dir_link = "index"
      let g:vimwiki_key_mappings = { "global": 0 }
      let g:vimwiki_global_ext = 0
      let g:vimwiki_list =
      \ [
      \   {
      \     'path': '~/mike-wiki',
      \     'syntax': 'markdown', 'ext': '.md'
      \   }
      \ ]

      " au commands

      "" Only show cursorline in active window
      au WinLeave * setl nocursorline
      au WinEnter * setl cursorline

      "" Autoreload file on change
      set autoread
      au CursorHold * checktime

      "" Remove trailing whitespace
      au BufWritePre * :%s/\s\+$//e

      "" Wrap Lines when writing Markdown
      au BufRead,BufNewFile *.md setlocal textwidth=80

      "" Fix netrw mm and mc commands by updating lcd as you navigate
      "" Keep everything else working by updating lcd back to the global
      let g:netrw_keepdir = 0
      au BufLeave * exe "lcd" getcwd(-1)

      "" Turn on spell check for certain filetypes
      au FileType gitcommit setl spell

      "" Format code on save
      augroup fmt
        autocmd!
        autocmd BufWritePre * Neoformat
      augroup END

      "" Recognize go templates
      au BufReadPost *.go.tmpl set ft=gohtmltmpl

      "" Search vimwiki with FZF when open
      au BufRead */mike-wiki/* lcd ~/mike-wiki

      " Keybinds

      let mapleader = ","

      inoremap jk <ESC>

      "" fzf
      noremap <silent> <C-P> :call fzf#run(fzf#wrap({
      \ "source": "${pkgs.ripgrep}/bin/rg --files \| ${pkgs.similar-sort}/bin/similar-sort \"" . @% . "\"",
      \ "options": ['--tiebreak', 'index', '--preview', '${fzfVimPreview} {}'],
      \ "window": {'width': 1, 'height': 0.5, 'yoffset': 1},
      \ }))<CR>

      "" Open file explorer
      noremap <C-E>e :Explore<CR>
      noremap <C-E>s :Hexplore<CR>
      noremap <C-E>v :Vexplore<CR>

      "" Ale
      nnoremap <leader>e] :ALENextWrap<CR>
      nnoremap <leader>e[ :ALEPreviousWrap<CR>
      nnoremap <leader>ed :ALEDetail<CR>
      nnoremap <C-[> :ALEHover<CR>
      nnoremap <C-]> :call GoTo()<CR>

      """ Keep default behavior when browsing help files
      function! GoTo()
        if &ft == 'help'
          execute "tag " . expand("<cword>")
        else
          execute "ALEGoToDefinition"
        endif
      endfunction

      "" Session management
      noremap <leader>ss :mks! ~/.vimsession<CR>
      noremap <leader>os :so ~/.vimsession<CR>

      "" Git
      noremap <C-G>s :Git<CR>
      noremap <C-G>l :Glog<CR>
      noremap <C-G>b :Gblame<CR>
      noremap <C-G>h :Gbrowse<CR>
      noremap <C-G>e :Gedit<CR>

      "" Rails
      noremap <leader>ra :A<CR>
      noremap <leader>re :R<CR>

      "" vim-test
      noremap tt :TestFile<CR>
      noremap tn :TestNearest<CR>
      noremap ta :TestSuite<CR>
      noremap tl :execute "Tmux bundle exec rubocop " . expand("%:p")<CR>

      "" vimwiki
      noremap <leader>xx :VimwikiIndex<CR>
      noremap <leader>xt :VimwikiTabIndex<CR>

      "" Saving
      noremap <leader>w :w<CR>
      noremap <C-S> :w<CR>
      inoremap <C-S> :w<CR>

      "" Misc

      noremap <leader>ct :!column -t<CR>
      noremap <silent> <leader>cw :call ToggleCW()<CR>
      noremap <leader>n :noh<CR>
      noremap <leader>q :q<CR>
      noremap <leader>rs :syntax sync fromstart<CR>

      " Colors

      set termguicolors
      colorscheme base16-ocean

      hi CursorLineNr cterm=bold

      " Functions

      function! ToggleCW()
        for i in range(1, winnr('$'))
          let l:bnum = winbufnr(i)
          if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
          endif
        endfor
        copen
      endfunction
    '';
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
