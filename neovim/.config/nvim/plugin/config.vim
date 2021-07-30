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
set hlsearch                                   " Highlight search results
set incsearch
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
set termguicolors

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

" -- Use pbcopy.exe/pbpaste.exe from pasteboard on Windows when we're using WSL
" -- Install pasteboard via [scoop](https://scoop.sh)
if system('uname -r') =~ 'Microsoft'
    let g:clipboard = {
    \   'name': 'WSLClipboard',
    \   'copy': {
    \       '+': 'pbcopy.exe',
    \       '*': 'pbcopy.exe',
    \   },
    \   'paste': {
    \       '+': 'pbpaste.exe --lf',
    \       '*': 'pbpaste.exe --lf',
    \   },
    \   'cache_enabled': 1
    \ }
endif

" -- Abbreviations
cnoreabbrev wrap set wrap
cnoreabbrev nowrap set nowrap
cnoreabbrev t tabe
cnoreabbrev T tabe

filetype plugin indent on  " Enable plugins and indents by filetype

