"Vim > Vi
set nocompatible
"set cc=80
set cmdheight=3

set wildmode=list:longest,full
set wildmenu
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set completeopt=menuone,menu,longest
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

"TODO : do something better
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

"TODO : do something better
function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?l:branchname:'no git'
endfunction

set laststatus=2
set statusline=
set statusline+=[%{StatuslineGit()}]
set statusline+=\ %f\ %h%w%m%r
set statusline+=%=
set statusline+=\[%{&fileformat}\]
set statusline+=[%{&fileencoding?&fileencoding:&encoding}]
set statusline+=\ L:%l/%L\ (%p%%)\ C:%c%V\ P:%o(%B)

set t_Co=256
syn on
set background=dark
colors xoria256
"set cursorline
"highlight CursorLine ctermbg=lightgreen

"set ts=4
set softtabstop=2
set shiftwidth=2
set expandtab
set shiftround
set smarttab

"set cindent
"set cino=>1se1sj1s
set autoindent

filetype on
filetype plugin on
filetype indent on

"TODO : do something better
inoremap <Tab> <c-n>

let mapleader=","

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
nnoremap <silent> <Leader>n :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

cabbr <expr> %% expand('%:p:h')

autocmd InsertEnter * let @/=""
autocmd InsertLeave * let @/=""

set tags=./tags;

set encoding=utf-8
set fileencodings=utf-8
set secure

