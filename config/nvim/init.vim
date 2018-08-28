" Vim Plug {
call plug#begin('~/.local/share/nvim/plugged')
  " Deoplete - completion manager {
  " Possibly switch to neovim-completion-manager at some point?
  Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
    let g:deoplete#auto_complete_delay = 0
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_smart_case = 1
    let g:deoplete#omni_patterns = {}
    let g:deoplete#auto_completion_start_length = 1
    let g:deoplete#file#enable_buffer_path = 1
    " Language sources
    " C/C++
    let g:deoplete#sources = {}
    let g:deoplete#sources._ = []
    let g:deoplete#sources#clang#executable = '/usr/bin/clang'
    let g:deoplete#sources#clang#libclang_path = '/usr/lib64/libclang.so'
    let g:deoplete#sources#clang#clang_header = expand('/usr/lib64/clang/*/include')
    let g:deoplete#sources#clang#autofill_neomake = 1
    let g:deoplete#sources#clang#std = {'cpp': 'c++1z'}
    " rust
    let g:deoplete#sources#rust#racer_binary = expand('~/.cargo/bin/racer')
    let g:deoplete#sources#rust#rust_source_path = expand('~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src')
    " Use shift to traverse list
    imap <expr><tab>
          \ pumvisible() ? "\<c-n>" :
          \ neosnippet#expandable_or_jumpable() ?
          \ "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
    imap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
    imap <expr><cr>
          \ pumvisible() ? deoplete#mappings#close_popup() :
          \ "\<cr>\<Plug>AutoPairsReturn"
  " }
  " Deoplete language sources {
  Plug 'tweekmonster/deoplete-clang2'
  Plug 'pbogut/deoplete-elm'
  Plug 'zchee/deoplete-jedi'
  Plug 'sebastianmarkow/deoplete-rust'
  Plug 'zchee/deoplete-go'
  " }
  " Neosnippets - Expandable snippets {
  Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)
    xmap <C-k> <Plug>(neosnippet_expand_target)
    let g:neosnippet#snippets_directory = '~/.local/share/nvim/plugged/vim-snippets'
  " }
  " Vim-gitgutter - Show git diff info in gutter {
  Plug 'airblade/vim-gitgutter'
  " }
  " Vim-fugitive - git wrapper {
  Plug 'tpope/vim-fugitive'
  " }
  " Vim-snippets - extra snippets {
  Plug 'honza/vim-snippets'
  " }
  " Vim-better-whitespace - Highlight unwanted spaces {
  Plug 'ntpeters/vim-better-whitespace'
    let g:better_whitespace_enabled = 1
  " }
  " Auto-pairs - Auto insert pairs {
  Plug 'jiangmiao/auto-pairs'
  " }
  " Alchemist - IEx and elixir completion / info in nvim {
  Plug 'slashmili/alchemist.vim'
  " }
  " Neomake - Build and check for issues in the background {
  Plug 'neomake/neomake', { 'for': ['rust', 'elixir', 'cpp'] }
    let g:neomake_markdown_enabled_makers = []
    let g:neomake_elixir_enabled_makers = ['mix', 'credo']
    " Run neomake on save
    augroup localneomake
      autocmd! BufWritePost * Neomake
    augroup END
  " }
  " Vim-Closetag - automatically close tags for (x)HTML files
  Plug 'alvan/vim-closetag'
  let g:closetag_filenames = '*.html, *.xhtml, *.eex'
  " }
  " Paramount - Simple colorscheme {
  Plug 'owickstrom/vim-colors-paramount'
  " }
  " Nord - 16 colour colorscheme {
  Plug 'arcticicestudio/nord-vim'
  let g:nord_uniform_status_lines = 1
  " }
  " Vim Polyglot - Lazy load syntax for current file {
  Plug 'sheerun/vim-polyglot'
  " }
  " FZF - Fuzzy finder {
  Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
  " }
  " NERDcommenter - Easy commenting in (almost)any file {
  Plug 'scrooloose/nerdcommenter'
  " }
  " Echodoc - Display function signatures in status {
  Plug 'Shougo/echodoc.vim'
    let g:echodoc_enable_at_startup = 1
  " }
call plug#end()
" }

" General {
set foldmethod=marker
set foldmarker={,}
set foldlevel=0
syntax enable
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2
set hidden
set number
set relativenumber
set encoding=utf-8
set hlsearch
set incsearch
set ignorecase
set smartcase
set title
set clipboard=unnamedplus
set cmdheight=2
set spell spelllang=en_au
" }

" Look and feel {
colorscheme nord
set background=dark
set cursorline
set cursorcolumn
" }

" Mappings {
let g:mapleader=" "
map <silent><cr> :nohl<cr>
map <silent><leader>e :Explore<cr>
map <silent><leader>f :FZF<cr>
" }

" Deoplete filters {
call deoplete#custom#source('_', 'sorters', ['sorter_word'])
call deoplete#custom#source('ultisnips', 'rank', 9999)
" }
