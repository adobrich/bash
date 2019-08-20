" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'dracula/vim', {'as': 'dracula'}

Plug 'rhysd/git-messenger.vim'

Plug 'ciaranm/inkpot', {'as': 'inkpot'}

" Initialize plugin system
call plug#end()

" If hidden is not set, TextEdit might fail.
set hidden

" Colours
syntax enable
set background=dark
set termguicolors
colorscheme dracula
highlight Normal ctermbg=None

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" press <esc> to cancel.
nmap f <Plug>(coc-smartf-forward)
nmap F <Plug>(coc-smartf-backward)
nmap ; <Plug>(coc-smartf-repeat)
nmap , <Plug>(coc-smartf-repeat-opposite)

augroup Smartf
  autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=#6638F0
  autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#504945
augroup end

"" Vim Plug {
"call plug#begin('~/.local/share/nvim/plugged')
"  Plug 'neoclide/coc.nvim', {'branch': 'release'}
"  " use <tab> for trigger completion and navigate to the next complete item
"  " Language Client {
"  "Plug 'autozimu/LanguageClient-neovim', {
"    "\ 'branch': 'next',
"    "\ 'do': 'bash install.sh',
"    "\ }
"  "let g:LanguageClient_hasSnippetSupport = 1
"  "let g:LanguageClient_autoStart = 1
"  "let g:LanguageClient_serverCommands = {
"    "\ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly', 'rls'],
"    "\ 'python': ['/usr/local/bin/pyls'],
"    "\ }
"  "noremap <silent> H :call LanguageClient_textDocument_hover()<CR>
"  "noremap <silent> Z :call LanguageClient_textDocument_definition()<CR>
"  "noremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
"  "noremap <silent> S :call LanguageClient_textDocument_documentSymbol()<CR>
"  "" }
"  "" Deoplete - completion manager {
"  "Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
"    "let g:deoplete#auto_complete_delay = 1
"    "let g:deoplete#enable_at_startup = 1
"    "let g:deoplete#enable_smart_case = 1
"    "let g:deoplete#omni_patterns = {}
"    "let g:deoplete#auto_completion_start_length = 2
"    "let g:deoplete#file#enable_buffer_path = 1
"    "" Language sources
"    "" C/C++
"    "let g:deoplete#sources = {}
"    "let g:deoplete#sources._ = []
"    "let g:deoplete#sources#clang#executable = '/usr/bin/clang'
"    "let g:deoplete#sources#clang#libclang_path = '/usr/lib64/libclang.so'
"    "let g:deoplete#sources#clang#clang_header = expand('/usr/lib64/clang/*/include')
"    "let g:deoplete#sources#clang#autofill_neomake = 1
"    "let g:deoplete#sources#clang#std = {'cpp': 'c++1z'}
"    "" rust
"    "let g:deoplete#sources#rust#racer_binary = expand('~/.cargo/bin/racer')
"    "let g:deoplete#sources#rust#rust_source_path = expand('~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src')
"    "" Use shift to traverse list
"    "imap <expr><tab>
"          "\ pumvisible() ? "\<c-n>" :
"          "\ neosnippet#expandable_or_jumpable() ?
"          "\ "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
"    "imap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
"    "imap <expr><cr>
"          "\ pumvisible() ? deoplete#mappings#close_popup() :
"          "\ "\<cr>\<Plug>AutoPairsReturn"
"  "" }
"  "" Deoplete language sources {
"  "Plug 'tweekmonster/deoplete-clang2'
"  "Plug 'pbogut/deoplete-elm'
"  "Plug 'zchee/deoplete-jedi'
"  ""Plug 'racer-rust/vim-racer'
"    "let g:racer_cmd = expand('~/.cargo/bin/racer')
"    "let g:racer_experimental_completer = 1
"  "Plug 'zchee/deoplete-go'
"  "" }
"  "" Neosnippets - Expandable snippets {
"  "Plug 'Shougo/neosnippet.vim'
"  "Plug 'Shougo/neosnippet-snippets'
"    "imap <C-k> <Plug>(neosnippet_expand_or_jump)
"    "smap <C-k> <Plug>(neosnippet_expand_or_jump)
"    "xmap <C-k> <Plug>(neosnippet_expand_target)
"    "let g:neosnippet#snippets_directory = '~/.local/share/nvim/plugged/vim-snippets'
"    "let g:neosnippet#enable_complete_done = 1
"  "" }
"  " Vim-gitgutter - Show git diff info in gutter {
"  Plug 'airblade/vim-gitgutter'
"    set signcolumn=yes
"  " }
"  " Vim-fugitive - git wrapper {
"  Plug 'tpope/vim-fugitive'
"  " }
"  " Vim-snippets - extra snippets {
"  Plug 'honza/vim-snippets'
"  " }
"  " Vim-better-whitespace - Highlight unwanted spaces {
"  Plug 'ntpeters/vim-better-whitespace'
"    let g:better_whitespace_enabled = 1
"  " }
"  " Vim-sandwich {
"  Plug 'machakann/vim-sandwich'
"  " }
"  " Auto-pairs - Auto insert pairs {
"  "Plug 'jiangmiao/auto-pairs'
"  " }
"  " Alchemist - IEx and elixir completion / info in nvim {
"  Plug 'slashmili/alchemist.vim'
"  " }
"  " Neomake - Build and check for issues in the background {
"  Plug 'neomake/neomake', { 'for': ['rust', 'elixir', 'cpp'] }
"    let g:neomake_markdown_enabled_makers = []
"    let g:neomake_elixir_enabled_makers = ['mix', 'credo']
"  " }
"  " Vim-Closetag - automatically close tags for (x)HTML files {
"  Plug 'alvan/vim-closetag'
"  let g:closetag_filenames = '*.html, *.xhtml, *.eex'
"  " }
"  " Paramount - Simple colorscheme {
"  Plug 'owickstrom/vim-colors-paramount'
"  " }
"  " Base16 - colorscheme {
"  Plug 'chriskempson/base16-vim'
"  " }
"  " Nord - 16 colour colorscheme {
"  Plug 'arcticicestudio/nord-vim'
"  let g:nord_uniform_status_lines = 1
"  let g:nord_comment_brightness = 20
"  let g:nord_uniform_background = 1
"  let g:nord_cursor_line_number_background = 1
"  " }
"  " Base-16 colorscheme {
"  Plug 'chriskempson/base16-vim'
"  " }
"  " Vim Polyglot - Lazy load syntax for current file {
"  Plug 'sheerun/vim-polyglot'
"  " }
"  " FZF - Fuzzy finder {
"  Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
"  " }
"  " NERDcommenter - Easy commenting in (almost)any file {
"  Plug 'scrooloose/nerdcommenter'
"  " }
"  " Echodoc - Display function signatures in status {
"  Plug 'Shougo/echodoc.vim'
"    let g:echodoc_enable_at_startup = 1
"  " }
"call plug#end()
"" }
"
"" Auto commands {
"" Close preview window after completion as been performed
""autocmd CompleteDone * pclose
"autocmd BufWritePost *.rs Neomake! cargo
"" }
"
"" General {
"set foldmethod=marker
"set foldmarker={,}
"set foldlevel=0
"syntax enable
"set tabstop=2
"set softtabstop=2
"set expandtab
"set shiftwidth=2
"set hidden
"set number
"set relativenumber
"set encoding=utf-8
"set hlsearch
"set incsearch
"set ignorecase
"set smartcase
"set title
"set clipboard=unnamedplus
"set cmdheight=2
"set spell spelllang=en_au
"set scrolloff=3
"set updatetime=300
"set shortmess+=c
"set signcolumn=yes
"" }
"
"" Look and feel {
""if filereadable(expand("~/.vimrc_background"))
"  "" Fix highlighting for spell checks in terminal
"  "function! s:base16_customize() abort
"    "" Colors: https://github.com/chriskempson/base16/blob/master/styling.md
"    "" Arguments: group, guifg, guibg, ctermfg, ctermbg, attr, guisp
"    "call Base16hi("SpellBad",   "", "", g:base16_cterm08, g:base16_cterm00, "", "")
"    "call Base16hi("SpellCap",   "", "", g:base16_cterm0A, g:base16_cterm00, "", "")
"    "call Base16hi("SpellLocal", "", "", g:base16_cterm0D, g:base16_cterm00, "", "")
"    "call Base16hi("SpellRare",  "", "", g:base16_cterm0B, g:base16_cterm00, "", "")
"  "endfunction
"
"  "augroup on_change_colorschema
"    "autocmd!
"    "autocmd ColorScheme * call s:base16_customize()
"  "augroup END
"  "let base16colorspace=256
"  "source ~/.vimrc_background
""endif
"
"colorscheme paramount
"set background=dark
"set cursorline
"set cursorcolumn
"" }
"
"" Mappings {
"let g:mapleader=" "
"map <silent><cr> :nohl<cr>
"map <silent><leader>e :Explore<cr>
"map <silent><leader>f :FZF<cr>
"map <F5> :setlocal spell! spelllang=en_au<CR>
"" }
"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~ '\s'
"endfunction
"
"inoremap <silent><expr> <Tab>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<Tab>" :
"      \ coc#refresh()
"
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <silent><expr> <c-space> coc#refresh()
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"
"" Use `[c` and `]c` to navigate diagnostics
"nmap <silent> [c <Plug>(coc-diagnostic-prev)
"nmap <silent> ]c <Plug>(coc-diagnostic-next)
"
"" Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"
"" Use K to show documentation in preview window
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"
"function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  else
"    call CocAction('doHover')
"  endif
"endfunction
""
"" Remap for rename current word
"nmap <leader>rn <Plug>(coc-rename)
"
"" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')
"
"" Remap for rename current word
"nmap <leader>rn <Plug>(coc-rename)
" "Deoplete filters {
""call deoplete#custom#source('_', 'sorters', ['sorter_word'])
""call deoplete#custom#source('ultisnips', 'rank', 9999)
" "}
