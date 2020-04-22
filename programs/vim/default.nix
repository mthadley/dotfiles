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
      rev = "de4c4fc5d879c8d82668e47384f80ff45c1bfb42";
      sha256 = "170xi335b83rqcwq0dgdk8m13lic8lbn8vi2p7qp4yhwvqqv59q2";
    };
  };

  vim-rails = pkgs.vimUtils.buildVimPlugin {
    name = "vim-rails";
    src = pkgs.fetchFromGitHub {
      owner = "tpope";
      repo = "vim-rails";
      rev = "184d12e85a17c85c548aeecc5b5c8c3182bd22e9";
      sha256 = "01z88hrqcqqp2cd5dwffiijhzfp0pr32dvmb5ai62y8zhfyn57m9";
    };
  };
in
{
  programs.neovim = {
    enable = true;

    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      ale
      auto-pairs
      base16-vim
      emmet-vim
      fzf-vim
      ranger-vim
      vim-abolish
      vim-commentary
      vim-fugitive
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
      vim-sleuth
      vim-sort-motion
      vim-surround
      vim-unimpaired
    ];

    extraConfig = ''
      set clipboard=unnamed
      set cursorline
      set dir=/tmp
      set expandtab
      set formatoptions+=j
      set hlsearch
      set ignorecase
      set mouse=a
      set nobackup
      set number
      set relativenumber
      set scrolloff=10
      set shiftwidth=2
      set splitbelow
      set splitright
      set sts=2
      set tabstop=2
      set nowritebackup

      "" Use rg as grepprg
      set grepprg=${pkgs.ripgrep}/bin/rg\ --vimgrep

      " Plugin Settings

      "" 'w0rp/ale'
      let g:ale_lint_delay = 1000
      let g:ale_lint_on_enter = 0
      let g:ale_elm_ls_elm_analyse_trigger = 'never'
      let g:ale_elm_ls_executable = '${pkgs.elmPackages.elm-language-server}/bin/elm-language-server'
      let g:ale_linters = {
      \   'javascript': ['eslint', 'flow', 'flow-language-server', 'standard', 'xo'],
      \   'haskell': ['hlint', 'hdevtools', 'hfmt'],
      \}
      hi ALEError cterm=underline

      "" chriskempson/base16-vim
      let g:base16colorspace=256

      "" junegunn/fzf.vim
      let g:fzf_action = {
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit' }

      """ Hide bar while fzf is open
      """ Taken from https://github.com/junegunn/fzf.vim#hide-statusline
      if has('nvim') || has('gui_running')
        autocmd! FileType fzf
        autocmd  FileType fzf set laststatus=0 noshowmode noruler norelativenumber
          \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler relativenumber
      endif

      "" ElmCast/elm-vim
      let g:elm_setup_keybindings = 0
      let g:elm_format_autosave = 1
      let g:elm_detailed_complete = 1

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

      " au commands

      "" Autoreload file on change
      set autoread
      au CursorHold * checktime

      "" Remove trailing whitespace
      au BufWritePre * :%s/\s\+$//e

      au BufRead,BufNewFile *.css set filetype=scss

      "" Wrap Lines when writing Markdown
      au BufRead,BufNewFile *.md setlocal textwidth=80

      "" Formatting js
      au FileType javascript setlocal formatprg=prettier

      "" Typescript hints
      au FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

      " Keybinds

      let g:user_emmet_leader_key = '<C-E>'
      let mapleader = ","

      inoremap jk <ESC>

      "" fzf
      noremap <C-P> :Files<CR>

      "" Open file explorer
      noremap <C-E>e :RangerEdit<CR>
      noremap <C-E>s :RangerSplit<CR>
      noremap <C-E>v :RangerVSplit<CR>

      "" Allow window movement in and exiting of terminal mode
      if has('nvim')
        tnoremap <C-W>j <C-\><C-n><C-w><C-j>
        tnoremap <C-W>k <C-\><C-n><C-w><C-k>
        tnoremap <C-W>h <C-\><C-n><C-w><C-h>
        tnoremap <C-W>l <C-\><C-n><C-w><C-l>

        augroup ranger_keys
          "" Otherwise, entering insert mode in Ranger seems to open stuff randomly
          "" in netrw... even though it should be disabled.
          au!
          au FileType netrw noremap <buffer> i :startinsert<CR>
        augroup END
      endif

      "" Ale
      nnoremap <leader>e] :ALENextWrap<CR>
      nnoremap <leader>e[ :ALEPreviousWrap<CR>
      nnoremap <leader>ed :ALEDetail<CR>
      nnoremap <leader>h :ALEHover<CR>
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
      noremap <C-G>s :Gstatus<CR>
      noremap <C-G>l :Glog<CR>
      noremap <C-G>b :Gblame<CR>
      noremap <C-G>h :Gbrowse<CR>
      noremap <C-G>e :Gedit<CR>

      "" Rails
      noremap <leader>ra :A<CR>
      noremap <leader>re :R<CR>

      "" Misc

      noremap <leader>ct :!column -t<CR>
      noremap <leader>cw :call ToggleCW()<CR>
      noremap <leader>ev :e $MYVIMRC<CR>
      noremap <leader>n :noh<CR>
      noremap <leader>q :q<CR>
      noremap <leader>rs :syntax sync fromstart<CR>
      noremap <leader>w :w<CR>

      " Colors

      colorscheme base16-ocean
      set background=dark
      set termguicolors

      hi CursorLineNr cterm=bold

      " Setup persistent undo

      if has('persistent_undo')
        let undo_dir = expand('$HOME/.vim/undo_dir')
        if !isdirectory(undo_dir)
          call mkdir(undo_dir, "p", 0700)
        endif
        set undodir=$HOME/.vim/undo_dir
        set undofile
      endif

      " Functions

      function! ToggleCW()
        for i in range(1, winnr('$'))
          let bnum = winbufnr(i)
          if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
          endif
        endfor
        copen
      endfunction
    '';
  };
}
