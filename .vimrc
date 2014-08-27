" Vundle Stuff
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" let Vundle manage Vundle
"  " required!
Bundle 'gmarik/vundle'

Bundle 'kien/ctrlp.vim'
Bundle 'bling/vim-airline'
Bundle 'mattn/emmet-vim'
Bundle 'ervandew/supertab'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-sensible'
Bundle 'scrooloose/syntastic'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'scrooloose/nerdtree'

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
inoremap jk <ESC>
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" Disable Arrowkeys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop> 

let g:user_emmet_leader_key='<C-Z>'

" Colors
colorscheme Tomorrow-Night-Eighties
hi TabLineFill ctermfg=Black ctermbg=Black
hi TabLine ctermfg=Black ctermbg=Grey
hi TabLineSel ctermfg=Green ctermbg=Black
