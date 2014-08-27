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
set tabstop=4
set shiftwidth=4
set nobackup
set cursorline
set fileformats+=dos
inoremap jk <ESC>
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

let g:user_emmet_leader_key='<C-Z>'

colorscheme Tomorrow-Night-Eighties
