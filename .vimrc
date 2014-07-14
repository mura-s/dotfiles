"--------------------
" disable vi compatible
set nocompatible

"--------------------
" NeoBundle setting
filetype off	" required!

" for proxy environment
"let g:neobundle_default_git_protocol='https'

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
NeoBundle 'scrooloose/nerdtree'

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'

NeoBundle 'mattn/emmet-vim'
NeoBundle 'pangloss/vim-javascript'

NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'kana/vim-surround'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'scrooloose/nerdcommenter'

NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'

NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'altercation/vim-colors-solarized'

filetype on			" required!
filetype plugin on    
filetype indent on

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

set background=dark
colorscheme solarized

"--------------------
" completion setting
" neocomplcache
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_manual_completion_start_length = 2
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_max_list = 20
"let g:neocomplcache_enable_auto_select = 1
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> pumvisible() ? neocomplcache#cancel_popup() : "\<End>"
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" avoid conflict with vim-rails
let g:neocomplcache_force_overwrite_completefunc = 1

" completion color
hi Pmenu ctermfg=15 ctermbg=18 guibg=#666666
hi PmenuSel ctermbg=39 ctermfg=0 guibg=#8cd0d3 guifg=#666666
hi PmenuSbar guibg=#333333

" ruby completion
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1

" Enable heavy omni completion.
" if !exists('g:neocomplcache_omni_patterns')
  " let g:neocomplcache_force_omni_patterns = {}
" endif
" let g:neocomplcache_force_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

" set dictionary complete (<C-n> or <C-p>)
"set complete+=k

"--------------------
" key mapping
" omni completion
inoremap <C-o> <C-x><C-o>
" user defined completion
inoremap <C-u> <C-x><C-u>
" tag completion
inoremap <C-]> <C-x><C-]>
" include completion (<C-n> or <C-p> : for c_lang & ruby(require)) 
" inoremap <C-l> <C-x><C-i>

" clear search highlight
nnoremap <Esc><Esc> :noh<CR>

"--------------------
" other plugin
" rails-vim
let g:rails_level=4
"let g:rails_syntax=1
"let g:rails_default_file="app/controllers/application.rb"

" unite.vim
" setting
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    <Leader>f [unite]
" keymap
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]u :<C-u>Unite buffer file_mru<CR>
nnoremap <silent> [unite]d :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]f :<C-u>Unite file<CR>
nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
" nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>

" overwrite settings
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " quit unite with <ESC><ESC>
  nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
  inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
  " vsplit
  inoremap <silent> <buffer> <expr><C-v> unite#do_action('vsplit')
endfunction

" vim-ref
let g:ref_use_vimproc=1
let g:ref_refe_version=2
let g:ref_refe_encoding = 'utf-8'

" NERDTree
" keymap
nnoremap <silent><C-e> :NERDTreeToggle<CR>
let NERDTreeMapOpenSplit='s'
let NERDTreeMapOpenVSplit='v'
" print dotfiles (hidden dotfiles: Shift-I)
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
            \ 'active_filetypes': ['ruby', 'javascript'] }
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = ['jshint']

" quickrun
let g:quickrun_config = {
\  "_" : {
\    "outputter/buffer/split" : "15sp",
\    "outputter/buffer/into" : 1,
\    "runner" : "vimproc"
\  }
\}

" quickrun rspec_test only cursol line
let g:quickrun_config['ruby.rspec'] = { 'command': 'rspec', 'cmdopt': "-l %{line('.')}", 'exec': 'bundle exec %c %o %s %a' }
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

" matchit (default vim plugin)
" move def-end, if-endif with % key
source $VIMRUNTIME/macros/matchit.vim

" PreVim (for markdown file)
nnoremap <silent><Leader>m :PrevimOpen<CR>

"--------------------
" default tab width
au BufNewFile,BufRead * set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
" custom tab width
au BufNewFile,BufRead *.java,*.c set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
"au BufNewFile,BufRead *.rb,*.erb set tabstop=2 shiftwidth=2 softtabstop=2 expandtab "dictionary=~/.vim/dict/ruby.dict

" stop auto comment out
autocmd FileType * setlocal formatoptions-=ro

" move last edit position when opening file
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

