"" Plugins
call plug#begin('~/.vim/bundle')

Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'cakebaker/scss-syntax.vim'
Plug 'cespare/vim-toml'
Plug 'christoomey/vim-sort-motion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dag/vim-fish'
Plug 'duganchen/vim-soy'
Plug 'elixir-lang/vim-elixir'
Plug 'ElmCast/elm-vim'
Plug 'henrik/vim-indexed-search'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'lepture/vim-velocity'
Plug 'mattn/emmet-vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'mileszs/ack.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'plasticboy/vim-markdown'
Plug 'rust-lang/rust.vim'
Plug 'SirVer/ultisnips'
Plug 'slashmili/alchemist.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'travitch/hasksyn'
Plug 'w0rp/ale'

"" vim-jsx requires vim-javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

"" tsuquyomi requires vimproc
Plug 'Shougo/vimproc.vim'
Plug 'Quramy/tsuquyomi'

call plug#end()

" Settings

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

" Plugin Settings

"" Plug 'w0rp/ale'
let g:ale_linters = {'rust': ['rls']}

"" mileszs/ack.vim
let g:ackprg = 'ag --vimgrep'

"" ElmCast/elm-vim
let g:elm_setup_keybindings = 0
let g:elm_format_autosave = 1
let g:elm_make_show_warnings = 1
let g:elm_detailed_complete = 1

"" christoomey/vim-sort-motion
let g:sort_motion_flags = 'i'

"" pangloss/vim-javascript
let g:jsx_ext_required = 0
let g:javascript_plugin_jsdoc = 1

"" plasticboy/vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = ['js=javascript', 'ini=dosini']

"" itchyny/lightline.vim
let g:lightline = { 'colorscheme': 'solarized' }

"" ctrlpvim/ctrlp.vim
let g:ctrlp_cmd = 'CtrlPCurWD'
let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/]\.?(git|hg|svn|elm-stuff|node_modules|deps|classes|build)$',
      \ }

" Quramy/tsuquyomi - typescript
let g:tsuquyomi_completion_detail = 1

" au commands

"" Autoreload file on change
set autoread
au CursorHold * checktime

"" Remove trailing whitespace
au BufWritePre * :%s/\s\+$//e

"" Force syntax highlighting for certain file extensions
au BufRead,BufNewFile *.css set filetype=scss
au BufRead,BufNewFile *.jspf,*.tag set filetype=jsp

"" Liferay doesn't like trailing newlines...
au BufRead,BufNewFile */Liferay/* setlocal noeol nofixeol sw=4 sts=4 ts=4 noet

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

"" Open file explorer
noremap <C-E>e :Explore<CR>
noremap <C-E>s :Hexplore<CR>
noremap <C-E>v :Vexplore<CR>

"" Add trailing semicolon
noremap <leader>; m'A;<ESC>g`'

"" Join collection of items to a single line
noremap <leader>ja ?[\\|{\\|(<CR>v%Jx%lx:noh<CR>

"" Split collection of items to multiple lines
noremap <leader>sa ?[\\|{\\|(<CR>v%:s/,/\0\r/g<CR>wi<CR><ESC>%li<CR><ESC>?[\\|{\\|(<CR>v%=:noh<CR>

"" Session management
noremap <leader>ss :mks! ~/.vimsession<CR>
noremap <leader>os :so ~/.vimsession<CR>

"" Projections
noremap <C-A>a :A<CR>
noremap <C-A>s :AS<CR>
noremap <C-A>v :AV<CR>

"" Git
noremap <C-G>s :Gstatus<CR>
noremap <C-G>l :Glog<CR>
noremap <C-G>b :Gblame<CR>
noremap <C-G>h :Gbrowse<CR>
noremap <C-G>e :Gedit<CR>

"" Misc
noremap <leader>bw :set binary<CR>:w<CR>:set nobinary<CR>:ec "File Written(b)..."<CR>
noremap <leader>ccp :CtrlPClearAllCaches<CR>
noremap <leader>ct :!column -t<CR>
noremap <leader>ev :vsplit $MYVIMRC<CR>
noremap <leader>f :CtrlPFunky<CR>
noremap <leader>n :noh<CR>
noremap <leader>q :q<CR>
noremap <leader>rs :syntax sync fromstart<CR>
noremap <leader>w :w<CR>

"" Fix Arrows when in tmux
noremap <Esc>[A <Up>
noremap <Esc>[B <Down>
noremap <Esc>[C <Right>
noremap <Esc>[D <Left>

" Colors

colorscheme solarized
set background=dark

" Setup persistent undo
"
if has('persistent_undo')
    let undo_dir = expand('$HOME/.vim/undo_dir')
    if !isdirectory(undo_dir)
        call mkdir(undo_dir, "", 0700)
    endif
    set undodir=$HOME/.vim/undo_dir
    set undofile
endif

" Projections

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
