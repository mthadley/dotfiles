"" Vundle Stuff

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle.vim'

"" Plugins

" Plugin 'editorconfig/editorconfig-vim'
Plugin 'mileszs/ack.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'christoomey/vim-sort-motion'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'dag/vim-fish'
Plugin 'duganchen/vim-soy'
Plugin 'elixir-lang/vim-elixir'
Plugin 'ElmCast/elm-vim'
Plugin 'henrik/vim-indexed-search'
Plugin 'itchyny/lightline.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kchmck/vim-coffee-script'
Plugin 'lepture/vim-velocity'
Plugin 'mattn/emmet-vim'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'mthadley/syntastic-csf'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'slashmili/alchemist.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'travitch/hasksyn'

" vim-jsx requires vim-javascript
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

call vundle#end()
filetype plugin indent on

"" Settings

set clipboard+=unnamed
set cursorline
set dir=/tmp
set expandtab
set fileformats+=dos
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

"" Plugin Settings

let g:ackprg = 'ag --vimgrep'

let g:elm_setup_keybindings = 0
let g:elm_format_autosave = 1

let g:sort_motion_flags = 'i'

let g:jsx_ext_required = 0
let g:javascript_plugin_jsdoc = 1

let g:lightline = { 'colorscheme': 'solarized' }

let g:syntastic_css_checkers = ['csf']
let g:syntastic_javascript_checkers = ['csf']
let g:syntastic_mode_map = { 'passive_filetypes': ['html'] }
let g:syntastic_scss_checkers = ['csf']

let g:ctrlp_cmd = 'CtrlPCurWD'
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.?(git|hg|svn|node_modules|deps|classes|build)$',
	\ }

"" au commands

" Autoreload file on change
set autoread
au CursorHold * checktime

" Remove trailing whitespace
au BufWritePre * :%s/\s\+$//e

" Force syntax highlighting for certain file extensions
au BufRead,BufNewFile *.css set filetype=scss
au BufRead,BufNewFile *.jspf,*.tag set filetype=jsp

" Liferay doesn't like trailing newlines...
au BufRead,BufNewFile */Liferay/* setlocal noeol nofixeol sw=4 sts=4 ts=4 noet

" Wrap Lines when writing Markdown
au BufRead,BufNewFile *.md setlocal textwidth=80

"" Keybinds

let g:user_emmet_leader_key = '<C-E>'
let mapleader = ","

inoremap jk <ESC>

" Open file epxloer
noremap <C-E>e :Explore<CR>
noremap <C-E>s :Hexplore<CR>
noremap <C-E>v :Vexplore<CR>

" Add trailing semicolon
noremap <leader>; m'A;<ESC>g`'

" Join collection of items to a single line
noremap <leader>ja ?[\\|{\\|(<CR>v%Jx%lx:noh<CR>

" Split collection of items to multiple lines
noremap <leader>sa ?[\\|{\\|(<CR>v%:s/,/\0\r/g<CR>wi<CR><ESC>%li<CR><ESC>?[\\|{\\|(<CR>v%=:noh<CR>

" Session management
noremap <leader>ss :mks! ~/.vimsession<CR>
noremap <leader>os :so ~/.vimsession<CR>

" Projections
noremap <C-A>a :A<CR>
noremap <C-A>s :AS<CR>
noremap <C-A>v :AV<CR>

" Misc
noremap <leader>bw :set binary<CR>:w<CR>:set nobinary<CR>:ec "File Written(b)..."<CR>
noremap <leader>c :SyntasticToggleMode<CR>
noremap <leader>ccp :CtrlPClearAllCaches<CR>
noremap <leader>ct :!column -t<CR>
noremap <leader>ev :vsplit $MYVIMRC<CR>
noremap <leader>f :CtrlPFunky<CR>
noremap <leader>n :noh<CR>
noremap <leader>q :q<CR>
noremap <leader>rs :syntax sync fromstart<CR>
noremap <leader>w :w<CR>

" Fix Arrows when in tmux
noremap <Esc>[A <Up>
noremap <Esc>[B <Down>
noremap <Esc>[C <Right>
noremap <Esc>[D <Left>

"" Colors

set background=dark
colorscheme solarized

"" Projections

let g:projectionist_heuristics = {
	\ "package.json&build.xml&ivy.xml": {
	\		"**/__tests__/*.js": {
	\			"alternate": [
	\				"{}.js",
	\				"{dirname}/{basename|snakecase}/index.js"
	\			],
	\			"type": "test"
	\		},
	\		"*.js": {
	\			"alternate": [
	\				"{dirname}/__tests__/{basename}.js",
	\				"{dirname}/../__tests__/{dirname|basename|camelcase}.js"
	\			],
	\			"type": "source"
	\		}
	\ }}
