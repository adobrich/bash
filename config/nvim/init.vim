set nocompatible
set runtimepath+=$HOME/.nvim/dein/repos/github.com/Shougo/dein.vim       

if dein#load_state('~/.nvim/dein')
  call dein#begin('~/.nvim/dein')

  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-clang')
  call dein#add('carlitux/deoplete-ternjs')
  call dein#add('Shougo/neoinclude.vim')
  call dein#add('SirVer/ultisnips')
  call dein#add('honza/vim-snippets')
  call dein#add('othree/jspc.vim')
  call dein#add('ervandew/supertab')
  call dein#add('fxn/vim-monochrome')
  call dein#add('owickstrom/vim-colors-paramount')
  call dein#add('beigebrucewayne/skull-vim')
  call dein#add('neomake/neomake')
  call dein#add('airblade/vim-gitgutter')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable
let &colorcolumn="81,".join(range(121,999),",")

set number
set relativenumber
"colorscheme monochrome
colorscheme paramount
"colorscheme skull
set background=dark

set tabstop=4
set shiftwidth=4
set expandtab

let g:gitgutter_enabled = 1
set completeopt=longest,menuone,preview
let g:SuperTabClosePreviewOnPopupClose = 1
" Use deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
    \ 'tern#Complete',
    \ 'jspc#omni'
\]
let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_cpp_clang_args = {
    \ 'exe': 'clang++',
    \ 'args': ['-Wall', '-Wextra', '-Weverything', '-pedantic', 
    \ '-Wno-unused-parameter', '-std=c++y', '-DNDEBUG'],
    \}
call neomake#configure#automake('w')
let g:neomake_open_list = 2

" Clang completion
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'

" Javascript completion
let g:deoplete#sources#javascript = ['file', 'ultisnips', 'ternjs']

autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
