" Load Plugins
call plug#begin()
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer', { 'branch': 'main' }
    Plug 'hrsh7th/nvim-compe'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'

    Plug 'NTBBloodbath/galaxyline.nvim', { 'branch': 'main' } "Maintained galaxyline
    Plug 'kyazdani42/nvim-web-devicons'  " needed for galaxyline icons

    Plug 'nikvdp/neomux'

    Plug 'tpope/vim-ragtag'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'

    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fugitive'

    Plug 'tomtom/tcomment_vim'
call plug#end()

#colorscheme NeoSolarized
#colorscheme solarized8_high

autocmd!
scriptencoding utf-8
" stop loading config if it's on tiny or small
if !1 | finish | endif

set nocompatible
set title
set number "Show line number
set relativenumber
set autoindent
set tabstop=2
set shiftwidth=2
set smarttab
set softtabstop=2
set expandtab               " converts tabs to white space
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax enable               " syntax highlighting
set background=dark
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set ruler
set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=10
" incremental substitution (neovim)
if has('nvim')
  set inccommand=split
endif
" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=
set nosc noru nosm
" Don't redraw while executing macros (good performance config)
set lazyredraw
set nowrap "No Wrap lines
set backspace=start,eol,indent
" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*
" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Add asterisks in block comments
set formatoptions+=r

"}}}

" Set cursor line color on visual mode
highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40

highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

if &term =~ "screen"
  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif

" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.





" Syntax theme "{{{
" ---------------------------------------------------------------------

" true color
if exists("&termguicolors") && exists("&winblend")
  syntax enable
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
  set background=dark
  " Use NeoSolarized
  let g:neosolarized_termtrans=1
  runtime ./colors/NeoSolarized.vim
  colorscheme NeoSolarized
endif

"}}}













" set leader key to ,
let g:mapleader=","

" >> Telescope bindings
nnoremap <Leader>pp <cmd>lua require'telescope.builtin'.builtin{}<CR>
"}
" most recently used files
nnoremap <Leader>m <cmd>lua require'telescope.builtin'.oldfiles{}<CR>

" find buffer
nnoremap ; <cmd>lua require'telescope.builtin'.buffers{}<CR>

" find in current buffer
nnoremap <Leader>/ <cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>

" bookmarks
nnoremap <Leader>' <cmd>lua require'telescope.builtin'.marks{}<CR>

" git files
nnoremap <Leader>f <cmd>lua require'telescope.builtin'.git_files{}<CR>

" all files
nnoremap <Leader>bfs <cmd>lua require'telescope.builtin'.find_files{}<CR>

" ripgrep like grep through dir
nnoremap <Leader>rg <cmd>lua require'telescope.builtin'.live_grep{}<CR>

" pick color scheme
nnoremap <Leader>cs <cmd>lua require'telescope.builtin'.colorscheme{}<CR>


" >> setup nerdcomment key bindings
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1

xnoremap <Leader>ci <cmd>call NERDComment('n', 'toggle')<CR>
nnoremap <Leader>ci <cmd>call NERDComment('n', 'toggle')<CR>


" >> Lsp key bindings
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K     <cmd>Lspsaga hover_doc<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-p> <cmd>Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent> <C-n> <cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> gf    <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> gn    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> ga    <cmd>Lspsaga code_action<CR>
xnoremap <silent> ga    <cmd>Lspsaga range_code_action<CR>
nnoremap <silent> gs    <cmd>Lspsaga signature_help<CR>

lua <<EOF
require("lsp")
require("treesitter")
require("statusbar")
require("completion")
EOF

