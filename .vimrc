set nocompatible

"--------------------
" NeoBundle settings
filetype off  " required!

"let g:neobundle_default_git_protocol='https'  " for proxy environment

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#rc(expand('~/.vim/bundle/'))
endif
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\     'cygwin' : 'make -f make_cygwin.mak',
\    },
\ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'scrooloose/nerdtree'

NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'
NeoBundle 'vim-jp/vim-go-extra'
NeoBundle 'dgryski/vim-godef'

NeoBundle 'mattn/emmet-vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'

NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'kana/vim-surround'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'scrooloose/nerdcommenter'

NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'taka84u9/vim-ref-ri'

NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'altercation/vim-colors-solarized'

filetype plugin indent on  " required!

"--------------------
" default vim setting
syntax enable
set hlsearch
set incsearch
set ignorecase
set noswapfile
set autoindent
set autoread
set number
set backspace=indent,eol,start
set splitbelow
set splitright
" copy to vim-register & mac-clipboard
set clipboard+=unnamedplus,unnamed

set background=dark
colorscheme solarized

"--------------------
" completion setting
" neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#manual_completion_start_length = 2
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

" completion color
hi Pmenu ctermfg=15 ctermbg=18 guibg=#666666
hi PmenuSel ctermbg=39 ctermfg=0 guibg=#8cd0d3 guifg=#666666
hi PmenuSbar guibg=#333333

" avoid conflict with vim-rails
let g:neocomplete_force_overwrite_completefunc = 1

" ruby completion
autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
let g:rubycomplete_rails = 0
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_include_object = 1
let g:rubycomplete_include_object_space = 1

" enable heavy omni completion
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

"--------------------
" key mappings
" omni completion
inoremap <C-o> <C-x><C-o>

" user defined completion
inoremap <C-u> <C-x><C-u>

" tag jump
nnoremap <C-]> g<C-]>

" clear search highlight
nnoremap <Esc><Esc> :noh<CR>

"--------------------
" other plugins

" rails-vim
let g:rails_level=4  " enable rails-vim

" unite.vim
" setting
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 100
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    <Leader>f [unite]
" keymap
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]d :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> [unite]f :<C-u>Unite file file/new<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]g :<C-u>Unite grep<CR>
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

" vim-ref (keymap: Shift-k)
let g:ref_use_vimproc=1
let g:ref_refe_version=2
let g:ref_refe_encoding = 'utf-8'

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

" emmet
let g:user_emmet_leader_key='<C-t>'   " type '<C-t><C-t>,' if using tmux
let g:user_emmet_settings = {
\   'lang' : 'ja'
\ }

" syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

" syntastic for ruby & js
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['ruby', 'javascript', 'go'] }
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = ['jshint']

" quickrun
let g:quickrun_config = {
\  "_" : {
\    "outputter/buffer/split" : "20sp",
\    "outputter/buffer/into" : 1,
\    "runner" : "vimproc"
\  }
\}

" quickrun rspec_test only cursol line
let g:quickrun_config['ruby.rspec'] = { 'command': 'rspec', 'cmdopt': ":%{line('.')} -cfd", 'exec': 'bundle exec %c %s%o %a' }
augroup RSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

" lightline.vim
set laststatus=2
set t_Co=256
let g:lightline = {
\  'colorscheme': 'default',
\  'component': {
\    'readonly': '%{&readonly?"\u2b64":""}',
\  }
\}

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
hi IndentGuidesEven  ctermbg=black
nnoremap <silent><Leader>i :IndentGuidesToggle<CR>

" vim-endwise (avoid conflict with vim-smartinput)
let g:endwise_no_mappings = 1
autocmd FileType lua,ruby,sh,zsh,vb,vbnet,aspvbs,vim imap <buffer> <CR> <CR><Plug>DiscretionaryEnd

" matchit (move def-end, if-endif with % key)
source $VIMRUNTIME/macros/matchit.vim

" PreVim (for markdown file)
nnoremap <silent><Leader>m :PrevimOpen<CR>

" golang auto formatting
au BufWritePre *.go Fmt

" godef (use gd-key)
let g:godef_same_file_in_same_window = 1

" use goimports instead of gofmt
let g:gofmt_command = 'goimports'

"--------------------
" default tab width
au BufNewFile,BufRead * set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
" custom tab width
au BufNewFile,BufRead *.java,*.c,*.go set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab

au BufNewFile,BufRead *.coffee set filetype=coffee
au BufNewFile,BufRead *.md set filetype=markdown

" stop auto comment out
autocmd FileType * setlocal formatoptions-=ro

" move to last edit position when opening file
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\(\s\+$\|　\)/
augroup END
