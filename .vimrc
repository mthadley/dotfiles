" Vundle Stuff
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" let Vundle manage Vundle
"  " required!
Bundle 'gmarik/vundle'

Bundle 'Lokaltog/vim-easymotion'
Bundle 'bling/vim-airline'
Bundle 'bling/vim-bufferline'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'ervandew/supertab'
Bundle 'henrik/vim-indexed-search'
Bundle 'kien/ctrlp.vim'
Bundle 'lepture/vim-velocity'
Bundle 'mattn/emmet-vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'

filetype plugin indent on     " required!

" Vim Airline stuff
set encoding=UTF-8
set t_Co=256
set laststatus=2
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '

" Mike's stuff
set relativenumber
set ignorecase
set tabstop=4
set shiftwidth=4
set nobackup
set cursorline
set fileformats+=dos
set mouse=a
set hlsearch
let g:bufferline_echo = 0
inoremap jk <ESC>
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

let mapleader = ","
map <leader>t :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<CR>
map <leader>gh :Gbrowse<CR>
map <leader>w :buffer 

" Disable Arrowkeys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

let g:user_emmet_leader_key='<C-E>'

" Colors
colorscheme Tomorrow-Night-Eighties
hi TabLineFill ctermfg=Black ctermbg=Black
hi TabLine ctermfg=Black ctermbg=Grey
hi TabLineSel ctermfg=Green ctermbg=Black
