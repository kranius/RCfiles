"Vim > Vi
set nocompatible

"Options generiques
set wildmode=list:longest,full
set wildmenu
set smd
set hlsearch
set showmatch
set nu
set incsearch
set ignorecase
set smartcase
"set backspace=2
set backspace=indent,eol,start
set ut=1000
set formatoptions=crol

set laststatus=2
set statusline=%<%f\ %h%w%m%r%y%=L:%l/%L\ (%p%%)\ C:%c%V\ B:%o\ F:%{foldlevel('.')}

"les couleurs
set t_Co=256
syn on
set background=dark
"colors gardener
"colors jellybeans
colors xoria256
"colors solarized
"set cursorline
"highlight CursorLine ctermbg=lightgreen

"Comportement de la touche TAB

set ts=2
"set softtabstop=2
set sw=2
set expandtab
"set smarttab

"indentation
"set cindent
"set cino=>1se1sj1s
set autoindent

filetype on
filetype plugin on
filetype indent on

let mapleader=","

highlight WhitespaceEOL ctermbg=red
match WhitespaceEOL /\s\+$/
autocmd WinEnter * match WhiteSpaceEOL /\s\+$/
nnoremap <silent> <Leader>n :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

cabbr <expr> %% expand('%:p:h')

let g:neocomplcache_enable_at_startup = 1
let g:slimv_swank_cmd = '! xterm -e sbcl --load /usr/share/common-lisp/source/slime/start-swank.lisp &'

map <silent> <F4> :BufExplorer<CR>
map <silent> <F5> :TlistToggle<CR>
imap <silent> <F5> :TlistToggle<CR>
map <silent> <F6> :NERDTreeToggle<CR>
imap <silent> <F6> :NERDTreeToggle<CR>

autocmd InsertEnter * let @/=""
autocmd InsertLeave * let @/=""

au Bufenter *.hs compiler ghc
let g:haddock_browser = "/usr/bin/chromium"

set tags=~./tags,tags,~/.tags

set fileencodings=utf-8
set secure

