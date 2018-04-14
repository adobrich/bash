" Modeline {
" vim: et sw=2 sts=-1 foldmethod=marker foldmarker={,}
" }

set nocompatible

" Dein - Plugins {
set runtimepath+=$HOME/.nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.nvim/dein')
  call dein#begin('~/.nvim/dein')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('carlitux/deoplete-ternjs')
  call dein#add('eagletmt/neco-ghc')
  call dein#add('elixir-editors/vim-elixir')
  call dein#add('ElmCast/elm-vim')
  call dein#add('honza/vim-snippets')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('mattn/emmet-vim')
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('neomake/neomake')
  call dein#add('ntpeters/vim-better-whitespace')
  call dein#add('othree/jspc.vim')
  call dein#add('owickstrom/vim-colors-paramount')
  call dein#add('pbogut/deoplete-elm')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/echodoc.vim')
  call dein#add('Shougo/neoinclude.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('slashmili/alchemist.vim')
  call dein#add('tikhomirov/vim-glsl')
  call dein#add('tpope/vim-surround')
  call dein#add('Valloric/MatchTagAlways')
  call dein#add('tweekmonster/deoplete-clang2')
  "call dein#add('zchee/deoplete-clang')
  call dein#add('zchee/deoplete-jedi')
  call dein#end()
  call dein#save_state()
endif
" }

" General {
filetype plugin indent on
syntax enable

set clipboard+=unnamedplus
set completeopt-=preview
set completeopt+=menu,noinsert,noselect
set expandtab
set ignorecase
set lazyredraw
set modeline
set noshowmode
set numberwidth=2
set scrolloff=5
set shiftwidth=4
set showmatch
set smartcase
set softtabstop=-1
set spell spelllang=en_au
set splitbelow
set splitright
set textwidth=79
"set wildmenu
"set wildignore=*.o,*.obj,*~
"set wildignore+=tags
"set wildmode=longest:list,full

" }

" Interface {
colorscheme paramount
set background=dark
set ruler
set number
set relativenumber
set cmdheight=2
set foldmethod=indent
set foldnestmax=3
set foldlevel=0
let &colorcolumn="81,121"
highlight Pmenu ctermbg=white ctermfg=black gui=bold
" }

" Key bindings {
nmap <space> <Leader>
vmap <space> <Leader>

nmap <silent> <leader>s :set spell!<CR>
" }

" Plugin settings {
let g:gitgutter_enabled = 1

" Use deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#executable = '/usr/bin/clang'
let g:deoplete#sources#autofill_neomake = 1
let g:deoplete#auto_complete_start_length = 1

" Clang completion
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/5.0.0/include'
let g:deoplete#auto_complete_delay = 0
let g:echodoc_enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
"call deoplete#custom#set('_', 'sorters', ['sorter_word'])
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy', 'matcher_length'])

"call deoplete#custom#source('_', 'matchers', ['matcher_head'])
call deoplete#custom#source('neosnippet', 'rank', 9999)

call neomake#configure#automake('w')

call deoplete#complete_common_string()
"let g:neomake_open_list = 2


" Javascript completion
"let g:deoplete#sources#javascript = ['file', 'ultisnips', 'ternjs']


imap <expr><TAB> pumvisible() ? "\<C-n>" : (neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>")
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
imap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>\<Plug>AutoPairsReturn"
"imap <expr><TAB> pumvisible()? "\<C-n>" : "\<tab>"

" Indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235
" }

" NERDTree {
map <leader>e :NERDTreeToggle<CR>
" }

" File type settings {
au BufNewFile,BufRead *.html setlocal shiftwidth=2

au BufNewFile,BufRead *.css setlocal shiftwidth=2

" }

autocmd InsertLeave * if pumvisible() == 0 | pclose | endif
