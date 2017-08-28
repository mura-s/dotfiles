" plugin settings
filetype off
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'dracula/vim'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'scrooloose/syntastic'
Plug 'thinca/vim-quickrun'
Plug 'mileszs/ack.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tyru/open-browser.vim'

Plug 'editorconfig/editorconfig-vim'
Plug 'justmao945/vim-clang', { 'for': ['c', 'cpp'] }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install', 'for': 'javascript' }
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }
Plug 'kannokanno/previm', { 'for': 'markdown' }

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
set clipboard=unnamed
set mouse=a

" search
set hlsearch
set incsearch
set ignorecase

" trailing space
set list
set listchars=tab:»\ ,trail:-

" grep & quickfix window
autocmd QuickFixCmdPost *grep* cwindow

" stop auto comment out
autocmd FileType * setlocal formatoptions-=ro

" indent
au BufNewFile,BufRead * set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
au BufNewFile,BufRead *.c,*.cpp,*.py,*.java set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
au BufNewFile,BufRead *.go,Makefile set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab

" colorscheme
color dracula
hi Normal ctermbg=none
hi SpecialKey ctermfg=8 ctermbg=none

"--------------------
" key mappings
" clear search highlight
nnoremap <Esc><Esc> :noh<CR>

" move cursor
inoremap <C-f> <Right>
inoremap <C-b> <Left>
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" delete
inoremap <C-h> <BS>
inoremap <C-d> <Del>

"--------------------
" completion settings
" popup menu height
set pumheight=15

" disable completion preview window
set completeopt=menuone

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
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1

" go keymap
autocmd FileType go nmap gd <Plug>(go-def)
autocmd FileType go nmap gx <Plug>(go-def-split)
autocmd FileType go nmap gv <Plug>(go-def-vertical)
autocmd FileType go nmap <silent>ga :GoAlternate<CR>
autocmd FileType go nmap <silent>gi :GoInfo<CR>
autocmd FileType go nmap <silent>gc :GoCallees<CR>
autocmd FileType go nmap <silent>gr :GoRename<CR>
autocmd FileType go nmap <silent>K  :GoDoc<CR>

" python
autocmd FileType python nmap <silent>K :ShowDoc<CR>
let g:jedi#goto_definitions_command = "gd"

" js
autocmd FileType javascript nmap <silent>K :TernDoc<CR>
autocmd FileType javascript nmap <silent>gd :TernDef<CR>

"--------------------
" other plugins
" ctrlp
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_show_hidden = 1
let g:ctrlp_mruf_max = 500
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:15,results:50'
let g:ctrlp_custom_ignore = '\.DS_Store\|\.idea\|\.git\|node_modules\|target\|vendor'

" NERDTree
nnoremap <silent><C-e> :NERDTreeToggle<CR>
let NERDTreeMapOpenSplit='<C-x>'
let NERDTreeMapOpenVSplit='<C-v>'
let NERDTreeShowHidden = 1

" tagbar
nnoremap <silent><Leader>t :TagbarToggle<CR>

" syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
nnoremap <silent><Leader>s :SyntasticCheck<CR>
let g:syntastic_mode_map = {
\  'mode': 'passive',
\}
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
let g:syntastic_python_checkers = ['pyflakes', 'pep8']
let g:syntastic_javascript_checkers = ['eslint']

" quickrun (keymap: <Leader>r)
let g:quickrun_config = {
\  "_" : {
\    "outputter/buffer/split" : "15sp",
\    "outputter/buffer/into" : 1,
\  }
\}

" ack.vim (:Ack [options] {pattern} [{directories}])
let g:ackprg = 'ag --vimgrep'

" PreVim (for markdown file)
nnoremap <silent><Leader>m :PrevimOpen<CR>

" lightline.vim
set laststatus=2
set t_Co=256
let g:lightline = {
\  'colorscheme': 'Dracula',
\  'active': {
\    'left': [ [ 'mode', 'paste' ],
\              [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
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
