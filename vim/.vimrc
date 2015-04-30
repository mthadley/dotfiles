" Vundle Stuff
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" let Vundle manage Vundle
"  " required!
Bundle 'gmarik/vundle'

Bundle 'Lokaltog/vim-easymotion'
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'edkolev/tmuxline.vim'
Bundle 'ervandew/supertab'
Bundle 'henrik/vim-indexed-search'
Bundle 'jiangmiao/auto-pairs'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'lepture/vim-velocity'
Bundle 'mattn/emmet-vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-sleuth'
Bundle 'tpope/vim-surround'
Bundle 'chriskempson/base16-vim'

filetype plugin indent on     " required!

" Vim Airline stuff
set encoding=UTF-8
set t_Co=256
set laststatus=2
let g:airline_theme='tomorrow'
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '

" Mike's stuff
set cursorline
set fileformats+=dos
set ignorecase
set mouse=a
set nobackup
set number
set relativenumber
set shiftwidth=4
set tabstop=4
set hlsearch
let g:bufferline_echo = 0
inoremap jk <ESC>
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
let g:ctrlp_cmd = 'CtrlPCurWD'

" Autoreload file on change
set autoread
au CursorHold * checktime

let g:gitgutter_sign_removed = '-'

au BufRead,BufNewFile *.css set filetype=scss.css

let g:tmuxline_preset = 'full'
let g:tmuxline_powerline_separators = 0

let mapleader = ","
map <leader>t :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<CR>
map <leader>gh :Gbrowse<CR>
map <leader>s :buffer
map <leader>c :SyntasticToggleMode<CR>
map <leader>w :set binary<CR>:w<CR>:set nobinary<CR>:ec "File Written(b)..."<CR>

let g:user_emmet_leader_key='<C-E>'

" Colors
let g:base16colorspace=256
colorscheme Tomorrow-Night-Eighties
hi TabLineFill ctermfg=Black ctermbg=Black
hi TabLine ctermfg=Black ctermbg=Grey
hi TabLineSel ctermfg=Green ctermbg=Black

hi Search cterm=NONE ctermfg=black ctermbg=grey

highlight clear SignColumn
highlight GitGutterAddLine ctermbg=Black
highlight GitGutterChangeLine ctermbg=Black
highlight GitGutterDeleteLine ctermbg=Black
highlight GitGutterChangeDeleteLine ctermbg=Black


