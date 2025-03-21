""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Must Have
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set background=dark
syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=1000             " How many lines of history to remember
set cf                       " enable error files and error jumping
set fileformats=unix,dos,mac " support all three, in this order
set viminfo+=!               " make sure it can save viminfo
set iskeyword+=_,$,@,%,#     " none of these should be word dividers, so make them not be
set nostartofline            " leave my cursor where it was

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files/Backups
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backup                          " make backup file
set backupdir=~/.config/vim/backup  " where to put backup files
set directory=~/.config/vim/temp    " directory for temp files
set makeef=error.err                " When using make, where should it dump the file
set sessionoptions+=globals         " What should be saved during sessions being saved
set sessionoptions+=localoptions    " What should be saved during sessions being saved
set sessionoptions+=resize          " What should be saved during sessions being saved
set sessionoptions+=winpos          " What should be saved during sessions being saved

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set linespace=0                      " space it out a little more (easier to read)
set wildmenu                         " turn on wild menu
set wildmode=list:longest            " turn on wild menu in special format (long format)
set wildignore=*.dll,*.o,*.so,*.obj,*.bak,*.exe,*.pyc,*.swp,*.jpg,*.gif,*.png,*.tar,*.tar.gz,*.tgz,*.tar.bz2,*.tbz " ignore formats
set ruler                            " Always show current positions along the bottom
set cmdheight=1                      " the command bar is 1 high
set number                           " turn on line numbers
set relativenumber                   " ...and show line numbers relative to the current line
set lazyredraw                       " do not redraw while running macros (much faster) (LazyRedraw)
set hidden                           " you can change buffer without saving
set backspace=2                      " make backspace work normal
set whichwrap+=<,>,h,l               " backspace and cursor keys wrap to
set mouse=a                          " use mouse everywhere
set shortmess=atI                    " shortens messages to avoid 'press a key' prompt
set report=0                         " tell us when anything is changed via :...
set noerrorbells                     " don't make noise
set list                             " we do what to show tabs, to ensure we get them out of my files
set listchars=tab:>-,trail:-         "  show tabs and trailing whitespace

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Cues
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showmatch    " show matching brackets
set mat=5        " how many tenths of a second to blink matching brackets for
set nohlsearch   " do not highlight searched for phrases
set incsearch    " BUT do highlight as you type you search phrase
set so=5         " Keep 5 lines (top/bottom) for scope
set novisualbell " don't blink
" statusline example: ~\myfile[+] [FORMAT=format] [TYPE=type] [ASCII=000] [HEX=00] [POS=0000,0000][00%] [LEN=000]
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2 " always show the status line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent Related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent            " autoindent (filetype indenting instead)
set nosmartindent         " smartindent (filetype indenting instead)
set cindent               " do c-style indenting
set softtabstop=4         " unify
set shiftwidth=4          " unify
set tabstop=4             " real tabs should be 4, but they will show with set list on
set copyindent            " but above all -- follow the conventions laid before us
filetype plugin indent on " load filetype plugins and indent settings

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Formatting/Layout
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fo=tcrq                          " See Help (complex)
set shiftround                       " when at 3 spaces, and I hit > ... go to 4, not 5
set expandtab                        " no real tabs!
set nowrap                           " do not wrap line
set preserveindent                   " but above all -- follow the conventions laid before us
set ignorecase                       " case insensitive by default
set smartcase                        " if there are caps, go case-sensitive
set completeopt=menu,longest,preview " improve the way autocomplete works

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"    Enable folding, but by default make it act like folding is
"    off, because folding is annoying in anything but a few rare
"    cases
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable         " Turn on folding
set foldmarker={,}     " Fold C style code
set foldmethod=marker  " Fold on the marker
set foldlevel=100      " Don't autofold anything (but I can still fold manually)
set foldopen-=search   " don't open folds when you search into them
set foldopen-=undo     " don't open folds when you undo stuff

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Change paging overlap amount from 2 to 5 (+3)
" if you swapped C-y and C-e, and set them to 2, it would
" remove any overlap between pages
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-f> <C-f>3<C-y> " Make overlap 3 extra on control-f
nnoremap <C-b> <C-b>3<C-e> "  Make overlap 3 extra on control-b

