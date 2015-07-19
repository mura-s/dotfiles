set nocompatible

"--------------------
" NeoBundle settings
filetype off  " required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\     'cygwin' : 'make -f make_cygwin.mak',
\    },
\ }

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'scrooloose/nerdtree'

NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'
NeoBundle 'fatih/vim-go'
NeoBundle 'dgryski/vim-godef'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'mxw/vim-jsx'

NeoBundle 'kana/vim-smartinput'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'scrooloose/nerdcommenter'

NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'

NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tomasr/molokai'

call neobundle#end()
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

set background=dark
let g:rehash256 = 1  " use monokai color
colorscheme molokai

"--------------------
" key mappings
" clear search highlight
nnoremap <Esc><Esc> :noh<CR>

" move cursor in insert mode
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" delete in insert mode
inoremap <C-d> <Del>

" move to the next visual line
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" esc
inoremap <C-@> <esc>
vnoremap <C-@> <esc>

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

" ruby completion
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

" js, coffee completion
let g:neocomplete#force_omni_input_patterns.javascript = '[^. \t]\.\%(\h\w*\)\?'
let g:neocomplete#force_omni_input_patterns.coffee = '[^. \t]\.\%(\h\w*\)\?'

" popup menu height
set pumheight=15

"--------------------
" golang
" use goimports instead of gofmt
let g:go_fmt_command = 'goimports'

" godef (keymap: gd)
let g:godef_split=0

" godoc (keymap: shift-k)
autocmd FileType go nmap <silent>K :Godoc<CR>

" disable complete preview window
set completeopt=menuone

"--------------------
" other plugins
" unite.vim
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
" The prefix key.
nnoremap    [unite]   <Nop>
nmap	<Leader>f [unite]
" keymap
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]d :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> [unite]f :<C-u>Unite file file/new<CR>
nnoremap <silent> [unite]g :<C-u>Unite -buffer-name=search-buffer grep<CR>
nnoremap <silent> [unite]s :<C-u>UniteResume search-buffer<CR>
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>

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
" syntastic for ruby, js, go
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = ['jshint']

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

" quickrun rspec_test only cursol line
let g:quickrun_config['ruby.rspec'] = {
\  'command': 'rspec', 'cmdopt': ":%{line('.')} -cfd", 'exec': 'bundle exec %c %s%o %a'
\}
augroup RSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

" vim-endwise (avoid conflict with vim-smartinput)
let g:endwise_no_mappings = 1
autocmd FileType lua,ruby,sh,zsh,vb,vbnet,aspvbs,vim imap <buffer> <CR> <CR><Plug>DiscretionaryEnd

" matchit (move def-end, if-endif with % key)
source $VIMRUNTIME/macros/matchit.vim

" PreVim (for markdown file)
nnoremap <silent><Leader>m :PrevimOpen<CR>
au BufNewFile,BufRead *.md set filetype=markdown

" lightline.vim
set laststatus=2
set t_Co=256
let g:lightline = {
\  'colorscheme': 'default',
\  'component': {
\    'readonly': '%{&readonly?"\u2b64":""}',
\  }
\}

"--------------------
" other settings
" indent
au BufNewFile,BufRead * set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
au BufNewFile,BufRead *.java,*.c,*.go set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab

" stop auto comment out
autocmd FileType * setlocal formatoptions-=ro

" move to last edit position when opening file
augroup vimrcEx
  autocmd!
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

" trailing space
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=239 ctermbg=239
  autocmd VimEnter,WinEnter * match TrailingSpaces /\(\s\+$\|　\)/
  " except unite.vim
  autocmd FileType unite match
augroup END
