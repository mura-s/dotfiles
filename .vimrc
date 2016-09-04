set nocompatible

"--------------------
" plugin settings
filetype off  " required!

call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', { 'dir': '~/.vim/plugged/vimproc.vim', 'do': 'make' }
Plug 'Shougo/unite.vim'
Plug 'scrooloose/nerdtree'

Plug 'Shougo/neocomplete' | Plug 'Shougo/neosnippet' | Plug 'Shougo/neosnippet-snippets'
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'eruby'] }
Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby'] }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'dgryski/vim-godef', { 'for': 'go' }
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

Plug 'tpope/vim-fugitive'
Plug 'kana/vim-smartinput'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-ref'

Plug 'kannokanno/previm', { 'for': 'markdown' }
Plug 'tyru/open-browser.vim'
Plug 'itchyny/lightline.vim'

call plug#end()
filetype plugin indent on  " required!

"--------------------
" basic settings
syntax enable
set number
set hlsearch
set incsearch
set ignorecase
set noswapfile
set autoindent
set autoread
set backspace=indent,eol,start
set splitbelow
set splitright

" trailing space
set list
set listchars=tab:»\ ,trail:-

" colorscheme
set background=dark
colorscheme Tomorrow-Night-Eighties

"--------------------
" key mappings
" clear search highlight
nnoremap <Esc><Esc> :noh<CR>

" move cursor
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" delete
inoremap <C-d> <Del>

" move to the next visual line
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

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

" ruby
autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
let g:rubycomplete_rails = 0
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_include_object = 1
let g:rubycomplete_include_object_space = 1

" enable rails-vim
let g:rails_level=4

" enable heavy omni completion (ruby)
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

" js
let g:neocomplete#force_omni_input_patterns.javascript = '[^. \t]\.\%(\h\w*\)\?'

" golang
" use goimports instead of gofmt
let g:go_fmt_command = 'goimports'

" godef (keymap: gd)
let g:godef_split=0

" godoc (keymap: shift-k)
autocmd FileType go nmap <silent>K :Godoc<CR>

" popup menu height
set pumheight=15

" disable completion preview window
set completeopt=menuone

"--------------------
" other plugins
" unite.vim
let g:unite_enable_start_insert=1
" prefix key
nnoremap    [unite]   <Nop>
nmap <Leader>f [unite]
" keymap
nnoremap <silent> [unite]f :<C-u>Unite file_rec/git<CR>
nnoremap <silent> [unite]d :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> [unite]g :<C-u>Unite -buffer-name=search-buffer grep/git<CR>
nnoremap <silent> [unite]s :<C-u>UniteResume search-buffer<CR>

" overwrite settings
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " quit unite.vim
  nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
  inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
  " move to parent directory
  imap <buffer> <C-h> <Plug>(unite_delete_backward_path)
  " split
  inoremap <silent> <buffer> <expr><C-j> unite#do_action('split')
  inoremap <silent> <buffer> <expr><C-l> unite#do_action('vsplit')
endfunction

" NERDTree
nnoremap <silent><C-e> :NERDTreeToggle<CR>
let NERDTreeMapOpenSplit='<C-j>'
let NERDTreeMapOpenVSplit='<C-l>'
" show dotfiles (hidden dotfiles: Shift-I)
let NERDTreeShowHidden = 1

" nerdcommenter
let NERDSpaceDelims = 1
nmap <Leader># <Plug>NERDCommenterToggle
vmap <Leader># <Plug>NERDCommenterToggle

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
" syntastic for ruby, js
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = ['eslint']

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

" quickrun for rspec
let g:quickrun_config['ruby.rspec'] = {
\  'command': 'rspec', 'cmdopt': ":%{line('.')} -cfd", 'exec': 'bundle exec %c %s%o %a'
\}
augroup RSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

" vim-endwise
let g:endwise_no_mappings = 1
autocmd FileType lua,ruby,sh,zsh,vb,vbnet,aspvbs,vim imap <buffer> <CR> <CR><Plug>DiscretionaryEnd

" matchit (move def-end, if-endif. keymap: %)
source $VIMRUNTIME/macros/matchit.vim

" PreVim (for markdown file)
nnoremap <silent><Leader>m :PrevimOpen<CR>
au BufNewFile,BufRead *.md set filetype=markdown

" lightline.vim
set laststatus=2
set t_Co=256
let g:lightline = {
  \ 'colorscheme': 'default',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component': {
  \   'readonly': '%{&filetype=="help"?"":&readonly?"RO":""}',
  \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
  \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
  \ },
  \ 'component_visible_condition': {
  \   'readonly': '(&filetype!="help"&& &readonly)',
  \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
  \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
  \ },
  \ }

"--------------------
" other settings
" indent
au BufNewFile,BufRead * set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
au BufNewFile,BufRead *.java,*.c,*.go set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab

" stop auto comment out
autocmd FileType * setlocal formatoptions-=ro

" move to last edit line when opening file
augroup vimrcEx
  autocmd!
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END
