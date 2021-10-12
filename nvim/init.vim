"
" plugins
"
call plug#begin(stdpath('data') . '/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-lua/completion-nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1
Plug 'kyazdani42/nvim-web-devicons'
call plug#end()

"
" basic settings
"
syntax on
set number
" indentation
set expandtab
set tabstop=4
set ruler
set smartindent
set shiftwidth=4
set autoindent
set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set backspace=indent,eol,start " allow backspacing over everything in insert mode
" search
set ignorecase      " ignore case
set smartcase     " but don't ignore it, when search string contains uppercase letters
set nocompatible
set incsearch        " do incremental searching
set hlsearch
set hidden
set ignorecase smartcase
set wildmenu
set wildmode=full
set path+=**
set virtualedit=all
" others
set scrolloff=5
set relativenumber
set visualbell
set shortmess=aIT
set mouse=a 
set tags=./tags;/ " ctags
set backupdir=/tmp//,. " Annoying temporary files
set directory=/tmp//,.
" Semi-persistent undo
if has('persistent_undo')
  set undodir=/tmp,.
  set undofile
endif
set clipboard=unnamed

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

autocmd CompleteDone * pclose

"
" key mappings
"
"let g:mapleader=";"

highlight Comment ctermfg=yellow
nnoremap <silent><CR> :nohlsearch<CR><CR>

nnoremap <Leader>l :buffers<CR>:buffers<Space>
nnoremap <Leader>p :bp<CR>
nnoremap <Leader>n :bn<CR>
nnoremap <Leader>d :Bd<CR>
command! Bd bp\|bd \#

" Fast Write and Quit
:command WQ wq
:command Wq wq
:command W w
:command Q q

" Open new line below and above current line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-^> <C-o><C-^>

nnoremap <silent> <Leader>f <cmd>Telescope find_files<cr>
nnoremap <silent> <Leader>r <cmd>Telescope live_grep<cr>
nnoremap <silent> <Leader>b <cmd>Telescope buffers<cr>
nnoremap <silent> <Leader><Leader> <cmd>Telescope help_tags<cr>

nnoremap <silent>K :Lspsaga hover_doc<CR>

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


lua <<EOF
require("lsp")
require("treesitter")
EOF

