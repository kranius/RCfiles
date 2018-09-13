set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
set termguicolors

call plug#begin('~/.local/share/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/repos/fzf', 'do': './install -all'}
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'ndmitchell/ghcid', {'rtp':'plugins/nvim'}
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': './install.sh'}

call plug#end()

let g:LanguageClient_serverCommands = {'haskell':['hie-wrapper']}
let g:LanguageClient_rootMarkers = ['*.cabal', 'stack.yaml']

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
map <Leader>lg :call LanguageClient#textDocument_definition()<CR>
map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
map <Leader>lb :call LanguageClient#textDocument_references()<CR>
map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>


let g:deoplete#enable_at_startup = 1

source ~/.vimrc

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
