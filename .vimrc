" plugins
filetype off
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'mura-s/badwolf', { 'branch': 'go-support' }

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'w0rp/ale'
Plug 'thinca/vim-quickrun'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'thinca/vim-visualstar'
Plug 'jiangmiao/auto-pairs'

Plug 'justmao945/vim-clang',       { 'for': ['c', 'cpp'] }
Plug 'fatih/vim-go',               { 'for': 'go' }
Plug 'davidhalter/jedi-vim',       { 'for': 'python' }
Plug 'pangloss/vim-javascript',    { 'for': 'javascript' }
Plug 'ternjs/tern_for_vim',        { 'do': 'npm install', 'for': 'javascript' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'stephpy/vim-yaml',           { 'for': 'yaml' }

call plug#end()
filetype plugin indent on

"--------------------
" basic settings
syntax enable
set number
set autoindent
set autoread
set noswapfile
set backspace=indent,eol,start
set hlsearch
set incsearch
set ignorecase
set splitright
set splitbelow
set clipboard=unnamed
set laststatus=2

" encodings
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" trailing space
set list
set listchars=tab:»\ ,trail:-

" disable completion preview window
set completeopt=menuone

" grep & quickfix window
au QuickFixCmdPost *grep* cwindow

" stop auto comment out
au FileType * setlocal formatoptions-=ro

" indent
au BufNewFile,BufRead * set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
au BufNewFile,BufRead *.c,*.cpp,*.py,*.java set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
au BufNewFile,BufRead *.go,*.mk,Makefile set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab

" colorscheme
set background=dark
color badwolf

"--------------------
" key mappings
nnoremap <Leader>\ :nohl<CR>
nnoremap <C-w>x <C-w>s
inoremap <C-o> <C-x><C-o>

" move
inoremap <C-f> <Right>
inoremap <C-b> <Left>
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" delete
inoremap <C-h> <BS>
inoremap <C-d> <Del>

" command
command! W w
command! Q q

"--------------------
" programming languages
" c, c++
let g:clang_auto = 0
let g:clang_c_completeopt = 'menuone'
let g:clang_cpp_completeopt = 'menuone'
let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++14 -stdlib=libc++'

" golang
let g:go_fmt_command = 'goimports'
let g:go_list_type = "quickfix"
let g:go_gocode_unimported_packages = 1

" go highlight
let g:go_highlight_build_constraints = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1

" go keymap
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap ga <Plug>(go-alternate-edit)
au FileType go nmap gi <Plug>(go-info)
au FileType go nmap gu <Plug>(go-referrers)
au FileType go nmap gr <Plug>(go-rename)
au FileType go nmap K <Plug>(go-doc)

" python
let g:jedi#popup_on_dot = 0
let g:jedi#goto_command   = "gd"
let g:jedi#usages_command = "gu"
let g:jedi#rename_command = "gr"
let g:jedi#documentation_command = "K"

" js
au FileType javascript nmap <silent>gd :TernDef<CR>
au FileType javascript nmap <silent>K :TernDoc<CR>

"--------------------
" other plugins
" fzf
nnoremap <silent><C-p> :Files<CR>
nnoremap <silent><Leader>f :Files<CR>
nnoremap <silent><Leader>b :Buffers<CR>
nnoremap <silent><Leader>m :History<CR>

" NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMapOpenSplit='<C-x>'
let g:NERDTreeMapOpenVSplit='<C-v>'
let g:NERDTreeMapRefreshRoot='<C-l>'
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" tagbar
nnoremap <silent><Leader>t :TagbarToggle<CR>

" ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_open_list = 1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
\  'c': ['clang', 'clangtidy'],
\  'cpp': ['clang', 'clangtidy'],
\  'go': ['gobuild', 'golint', 'govet'],
\  'python': ['flake8'],
\  'javascript': ['eslint'],
\  'typescript': ['tslint'],
\}

" quickrun (keymap: <Leader>r)
let g:quickrun_config = {
\  "_" : {
\    "outputter/buffer/split" : "15sp",
\    "outputter/buffer/into" : 1,
\  }
\}

" ack (:Ack [options] {pattern} [{directories}])
let g:ackprg = 'ag --vimgrep --hidden --ignore .git'

" lightline
let g:lightline = {
\  'colorscheme': 'default',
\  'active': {
\    'left': [ [ 'mode', 'paste' ],
\              [ 'fugitive', 'readonly', 'relativepath', 'modified' ] ]
\  },
\  'component': {
\    'readonly': '%{&filetype=="help"?"":&readonly?"RO":""}',
\    'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
\    'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
\  },
\  'component_visible_condition': {
\    'readonly': '(&filetype!="help"&& &readonly)',
\    'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
\    'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
\  }
\}
