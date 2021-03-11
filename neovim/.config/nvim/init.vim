let s:bundle_dir = expand('~/.config/nvim/bundle')
let s:plugin_dir = s:bundle_dir . '/repos/github.com'

call plug#begin('~/.config/nvim/plugged')
    Plug 'Raimondi/delimitMate'
    Plug 'airblade/vim-gitgutter'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'godlygeek/tabular'
    Plug 'gregsexton/MatchTag'
    Plug 'jremmen/vim-ripgrep'
    Plug 'junegunn/gv.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'mattn/emmet-vim', { 'for': 'blade,html' }
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'nelstrom/vim-visual-star-search'
    Plug 'rhysd/committia.vim'
    Plug 'rhysd/git-messenger.vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-scripts/AnsiEsc.vim'

    " LSP plugins
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    Plug 'tjdevries/nlua.nvim'
    Plug 'tjdevries/lsp_extensions.nvim'

    " telescope.nvim
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'

    " themes
    Plug 'kristijanhusak/vim-hybrid-material'
    Plug 'morhetz/gruvbox'
call plug#end()

lua require('aknackd')

set t_Co=256                                   " Set 256 colors
set title                                      " Change the terminal's title
set number                                     " Display line numbers
set relativenumber                             " ...and show line numbers relative to the current line
set history=500                                " Store lots of :cmdline history
set showcmd                                    " Show incomplete commands down the bottom
set noshowmode                                 " Hide showmode because of powerline
set gdefault                                   " Set global flag for search and replace
set gcr=a:blinkon500-blinkwait500-blinkoff500  " Set cursor blink rate
set cursorline                                 " Highlight current line
set smartcase                                  " Smart case search if there is uppercase
set ignorecase                                 " Case insensitive search
set mouse=c                                    " Enable mouse usage
set showmatch                                  " Highlight matching bracket
set nostartofline                              " Jump to first non-blank character
set timeoutlen=250 ttimeoutlen=100             " Reduce command timeout for faster escape
set fileencoding=utf-8                         " Set UTF-8 encoding on write
set nowrap                                     " Disable word wrap
set linebreak                                  " Wrap lines at convenient points
set list                                       " Enable listchars
set listchars=space:·,tab:\ \ ,trail:·         " Set trails for tabs and spaces
set lazyredraw                                 " Do not redraw on registers and macros
set completeopt-=preview                       " Disable preview for autocomplate
set hidden                                     " Hide buffers in background
set splitbelow                                 " Setup new horizontal splits below
set splitright                                 " Setup new vertical splits to the right
set path+=**                                   " Allow recursive search
set inccommand=split                           " Show substitute changes immediately
set cmdheight=2
set updatetime=250
set noswapfile                                 " Don't write a swap file
set nobackup
set nowritebackup
set undodir=~/.config/nvim/backups
set undofile
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set smartindent
set nofoldenable

set background=dark                            " Set background to dark
syntax on                                      " Enable syntax highlighting

filetype plugin indent on                      " Enable plugins and indents by filetype

silent! colorscheme hybrid_material
hi Normal guibg=NONE ctermbg=NONE
set termguicolors
let mapleader = ' '

" -- Abbreviations
cnoreabbrev wrap set wrap
cnoreabbrev nowrap set nowrap
cnoreabbrev t tabe
cnoreabbrev T tabe

" -- Remaps
nmap <leader>c gcc                          " Comment map
xmap <leader>c gc                           " Line comment command
nmap <leader>w :wincmd w<CR>                " Jump between windows
nmap ga <Plug>(EasyAlign)                   " vim-easy-align
xmap ga <Plug>(EasyAlign)                   " vim-easy-align
nnoremap + <c-w>5>                          " Increase window width
nnoremap - <c-w>5<                          " Decrease window width
nnoremap <leader>v <C-W>v<CR>               " Open vertical split
nnoremap <leader><space> :noh<CR>           " Clear search highlight
nnoremap <tab> >>                           " Tab to indent in normal mode
nnoremap <s-tab> <<                         " Shift+Tab to de-indent in normal mode
xnoremap <tab> >gv                          " Tab to indent in visual mode
xnoremap <s-tab> <gv                        " Shift+Tab to de-indent in visual mode
vnoremap <C-s-c> "+y                        " Copy to system clipboard
vnoremap J :m '>+1<CR>gv=gv                 " Move selected line(s) down
vnoremap K :m '<-2<CR>gv=gv                 " Move selected line(s) up
nnoremap <leader>gv :GV<CR>                 " Open git log
nnoremap <leader>gv! :GV<CR>                " Open git log
nnoremap <C-k> :cnext<CR>                   " Navigate to next item in the error list
nnoremap <C-j> :cprev<CR>                   " Navigate to previous item in the error list

" -- Find files using telescope.nvim
nnoremap <C-P> <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <C-T> <cmd>lua require('telescope.builtin').git_files()<CR>
nnoremap <C-F> <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<CR>

" -- Autocommands
augroup vimrc
    autocmd!
augroup END

autocmd vimrc BufWritePre * :call s:StripTrailingWhitespaces()   " Auto-remove trailing spaces
autocmd vimrc InsertEnter * :set nocul                           " Remove cursorline highlight
autocmd vimrc InsertLeave * :set cul                             " Add cursorline highlight in normal mode

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"     " Move to next tab completion item
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"   " Move to previous tab completion item"
set completeopt=menuone,noinsert,noselect
set shortmess+=c
let g:completion_matching_strategy_list = ['fuzzy', 'exact', 'substring', 'all']

" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.hover()<cr>
" nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
" nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<cr>
" nnoremap <silent> g0 <cmd>lua vim.lsp.buf.document_symbol()<cr>
" nnoremap <silent> gW <cmd>lua vim.lsp.buf.workspace_symbol()<cr>

" -- Functions
function! s:StripTrailingWhitespaces()
    let l:l = line(".")
    let l:c = col(".")
    %s/\s\+$//e
    call cursor(l:l, l:c)
endfunction

" -- Airline configuration
let g:airline_powerline_fonts = 1
let g:airline_theme = 'minimalist'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1

" -- Editorconfig configuration
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

" -- emmet configuration
let g:user_emmet_expandabbr_key = '<c-e>'        " Change trigger emmet key
let g:user_emmet_next_key = '<c-n>'              " Change trigger jump to next for emmet

" -- airline/vim-gitgutter configuration
let g:gitgutter_enabled = 1
let g:gitgutter_realtime = 0     " Disable gitgutter in realtime
let g:gitgutter_eager = 0        " Disable gitgutter eager load on tab

let g:ackhighlight = 1
let g:ackprg = 'rg --vimgrep'

