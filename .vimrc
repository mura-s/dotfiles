" plugin settings
filetype off  " required!
call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', { 'dir': '~/.vim/plugged/vimproc.vim', 'do': 'make' }

Plug 'Shougo/neocomplete' | Plug 'Shougo/neosnippet' | Plug 'Shougo/neosnippet-snippets'

Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'dgryski/vim-godef', { 'for': 'go' }

Plug 'davidhalter/jedi-vim', { 'for': ['python'] }

Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install', 'for': ['javascript', 'javascript.jsx'] }

Plug 'kannokanno/previm', { 'for': 'markdown' }

Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'kana/vim-smartinput'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-ref'
Plug 'tyru/open-browser.vim'

Plug 'itchyny/lightline.vim'
Plug 'dracula/vim'

call plug#end()
filetype plugin indent on  " required!

"--------------------
" basic settings
syntax enable
set number
set autoindent
set autoread
set noswapfile
set backspace=indent,eol,start

" search
set hlsearch
set incsearch
set ignorecase

" split
set splitbelow
set splitright

" trailing space
set list
set listchars=tab:»\ ,trail:-

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
inoremap <C-d> <Del>

"--------------------
" completion settings
" neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#auto_completion_start_length = 3
let g:neocomplete#manual_completion_start_length = 3
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()

" enable heavy omni completion
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

" golang
" use goimports instead of gofmt
let g:go_fmt_command = 'goimports'

" GoDef (keymap: gd)
let g:godef_split=0

" GoDescribe
autocmd FileType go nmap <silent>gp :GoDescribe<CR>

" GoDoc (keymap: K)
autocmd FileType go nmap <silent>K :GoDoc<CR>

" go highlight
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1

" python (Show Doc: K)
let g:jedi#goto_definitions_command = "gd"

" js
autocmd FileType javascript,javascript.jsx nmap <silent>K :TernDoc<CR>
autocmd FileType javascript,javascript.jsx nmap <silent>gd :TernDef<CR>

" popup menu height
set pumheight=15

" disable completion preview window
set completeopt=menuone

"--------------------
" other plugins
" ctrlp
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_show_hidden = 1
let g:ctrlp_mruf_max = 500
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:50'
let g:ctrlp_custom_ignore = '\.DS_Store\|\.idea\|\.git\|node_modules\|target'

" NERDTree
nnoremap <silent><C-e> :NERDTreeToggle<CR>
let NERDTreeMapOpenSplit='<C-x>'
let NERDTreeMapOpenVSplit='<C-v>'
let NERDTreeShowHidden = 1

" vim-ref (keymap: Shift-k)
let g:ref_use_vimproc=1
let g:ref_refe_version=2
let g:ref_refe_encoding = 'utf-8'

" syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
nnoremap <silent><Leader>s :SyntasticCheck<CR>
let g:syntastic_mode_map = {
\  'mode': 'passive',
\}
let g:syntastic_python_checkers = ['pyflakes', 'pep8']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:go_list_type = "quickfix"

" quickrun
nnoremap <silent><Leader>q :QuickRun<CR>
let g:quickrun_config = {
\  "_" : {
\    "outputter/buffer/split" : "15sp",
\    "outputter/buffer/into" : 1,
\    "runner" : "vimproc",
\    "runner/vimproc/updatetime" : 300
\  }
\}

" matchit (move def-end, if-endif. keymap: %)
source $VIMRUNTIME/macros/matchit.vim

" PreVim (for markdown file)
nnoremap <silent><Leader>m :PrevimOpen<CR>
au BufNewFile,BufRead *.md set filetype=markdown

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

"--------------------
" other settings
" indent
au BufNewFile,BufRead * set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
au BufNewFile,BufRead *.py,*.java set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
au BufNewFile,BufRead *.c,*.go set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab

" stop auto comment out
autocmd FileType * setlocal formatoptions-=ro

" move to last edit line when opening file
augroup vimrcEx
  autocmd!
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END
