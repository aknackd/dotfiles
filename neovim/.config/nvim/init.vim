let s:bundle_dir = expand('~/.config/nvim/bundle')
let s:plugin_dir = s:bundle_dir . '/repos/github.com'

call plug#begin('~/.config/nvim/plugged')
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'vim-scripts/AnsiEsc.vim'
    Plug 'w0rp/ale'
    Plug 'nelstrom/vim-visual-star-search'
    Plug 'jremmen/vim-ripgrep'
    Plug 'Raimondi/delimitMate'
    Plug 'mattn/emmet-vim'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-fugitive'
    Plug 'godlygeek/tabular'
    Plug 'sodapopcan/vim-twiggy'
    Plug 'rhysd/committia.vim'
    Plug 'rhysd/git-messenger.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'duff/vim-bufonly'
    Plug 'gregsexton/MatchTag'
    Plug 'sheerun/vim-polyglot'
    Plug 'junegunn/gv.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'kristijanhusak/vim-hybrid-material'

    " Plug 'terryma/vim-multiple-cursors'
    " Plug 'dikiaap/minimalist'
    " Plug 'nightsense/carbonized'
    " Plug 'NLKNguyen/papercolor-theme'
    " Plug 'rainglow/vim'
call plug#end()

filetype plugin indent on  " Enable plugins and indents by filetype

let mapleader = " "

let g:enable_bold_font = 1 " Enable bold font in colorscheme

" ================ General Config ====================

set t_Co=256                                   " Set 256 colors
set title                                      " Change the terminal's title
set number                                     " Line numbers are good
set relativenumber                             " Show numbers relative to current line
set history=500                                " Store lots of :cmdline history
set showcmd                                    " Show incomplete cmds down the bottom
set noshowmode                                 " Hide showmode because of the powerline plugin
set gdefault                                   " Set global flag for search and replace
set gcr=a:blinkon500-blinkwait500-blinkoff500  " Set cursor blinking rate
set cursorline                                 " Highlight current line
set smartcase                                  " Smart case search if there is uppercase
set ignorecase                                 " Case insensitive search
set mouse=c                                    " Enable mouse usage
set showmatch                                  " Highlight matching bracket
set nostartofline                              " Jump to first non-blank character
set timeoutlen=1000 ttimeoutlen=200            " Reduce Command timeout for faster escape and O
set fileencoding=utf-8                         " Set utf-8 encoding on write
set wrap                                       " Enable word wrap
set linebreak                                  " Wrap lines at convenient points
set listchars=space:·,tab:\ \ ,trail:·         " Set trails for tabs and spaces
set list                                       " Enable listchars
set lazyredraw                                 " Do not redraw on registers and macros
set completeopt-=preview                       " Disable preview for autocomplete
set background=dark                            " Set background to dark
set hidden                                     " Hide buffers in background
set splitbelow                                 " Set up new horozontal split below
set splitright                                 " Set up new vertical splits to the right
set path+=**                                   " Allow recursive search
set inccommand=split                           " Show substitute changes immidiately in separate split

syntax on                                      " Turn on syntax highlighting

silent! colorscheme hybrid_material
hi Normal guibg=NONE ctermbg=NONE
set termguicolors

set cmdheight=2
set updatetime=300

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowritebackup
set nowb

" ================ Persistent Undo ==================

" Keep undo history across sessions, by storing in file.
" silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
set undodir=~/.config/nvim/backups
set undofile

" ================ Indentation ======================

set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set smartindent
set nofoldenable

" ================ Auto commands ======================

augroup vimrc
    autocmd!
augroup END

autocmd vimrc BufWritePre * :call s:StripTrailingWhitespaces()                  "Auto-remove trailing spaces
autocmd vimrc InsertEnter * :set nocul                                          "Remove cursorline highlight
autocmd vimrc InsertLeave * :set cul                                            "Add cursorline highlight in normal mode
autocmd vimrc FileType html,javascript,coffee,cucumber setlocal sw=2 sts=2 ts=2 "Set 2 indent for html
autocmd vimrc FileType php,javascript setlocal cc=80                            "Set right margin only for php and js
autocmd vimrc VimEnter,BufNewFile,BufReadPost * call s:LoadLocalVimrc()         "Load per project vimrc (Used for custom test mappings, etc.)

autocmd vimrc VimEnter * set vb t_vb=

autocmd vimrc FileType nerdtree syntax match hideBracketsInNerdTree
            \ "\]" contained conceal containedin=ALL

" ================ Completion =======================

set wildmode=list:full
set wildignore=*.o,*.obj,*~     " Stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*cache*
set wildignore+=*logs*
set wildignore+=*node_modules/**
set wildignore+=*public/css/**/*.css
set wildignore+=*public/js/**/*.js
set wildignore+=*vendor/**
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8       " Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=5

" ================ Abbreviations ====================

cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd
cnoreabbrev wrap set wrap
cnoreabbrev nowrap set nowrap
cnoreabbrev bda BufOnly
cnoreabbrev t tabe
cnoreabbrev T tabe

" ================ Functions ========================

function! s:StripTrailingWhitespaces()
    let l:l = line(".")
    let l:c = col(".")
    %s/\s\+$//e
    call cursor(l:l, l:c)
endfunction

function! s:LoadLocalVimrc()
    if filereadable(glob(getcwd() . '/.vimrc.local'))
        :execute 'source '.fnameescape(glob(getcwd(). '/.vimrc.local'))
    endif
endfunction

function! SearchAndReplace(...) range
    let search = input('Search: ', '')
    if search != ''
        let isVisualMode = a:0
        let replace = input('Replace: ', '')
        let range = isVisualMode ? "'<,'>s/" : ":%s/"
        :execute range.search."/".replace
    endif
endfunction

" https://stackoverflow.com/questions/3878692/aliasing-a-command-in-vim/3879737#3879737
function! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" https://github.com/junegunn/fzf.vim/issues/664#issuecomment-476438294
function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': 1,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

" ================ Custom mappings ========================

nmap <Leader>c gcc       " Comment map
xmap <Leader>c gc        " Line comment command

xmap ga <Plug>(EasyAlign)  " vim-easy-align
nmap ga <Plug>(EasyAlign   " vim-easy-align

map <c-\> :Tabularize /=>/<CR>

" Map save to Ctrl + S
map <c-s> :w<CR>
imap <c-s> <C-o>:w<CR>

" Also save with ,w
nnoremap <Leader>w :w<CR>
nmap <Leader>k <Plug>(ale_previous_wrap)
nmap <Leader>j <Plug>(ale_next_wrap)

" Easier window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
" Open vertical split
nnoremap <Leader>v <C-w>v

" Down is really the next line
nnoremap j gj
nnoremap k gk

" Map for Escape key
inoremap jj <Esc>

" Yank to the end of the line
nnoremap Y y$

" Copy to system clipboard
vnoremap <C-c> "+y
" Paste from system clipboard with Ctrl + v
inoremap <C-v> <Esc>"+p
nnoremap <Leader>p "0p
vnoremap <Leader>p "0p

" Move to the end of yanked text after yank and paste
nnoremap p p`]
vnoremap y y`]
vnoremap p p`]

" Move selected lines up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Clear search highlight
nnoremap <Leader><space> :noh<CR>

noremap <Leader>gv :GV<CR>
noremap <Leader>gv! :GV<CR>

" Handle syntastic error window
nnoremap <Leader>e :lopen<CR>
nnoremap <Leader>q :lclose<CR>

" Toggle between last 2 buffers
nnoremap <leader><tab> <c-^>

" Auto change directory to match current file
nnoremap <Leader>dc :cd %:p:h<CR>:pwd<CR>

" Maps for indentation in normal mode
nnoremap <tab> >>
nnoremap <s-tab> <<

" Indenting in visual mode
xnoremap <s-tab> <gv
xnoremap <tab> >gv

" Resize window with shift + and shift -
nnoremap + <c-w>5>
nnoremap _ <c-w>5<

" Center highlighted search
nnoremap n nzz
nnoremap N Nzz

" Search and replace in visual highlight
vnoremap <Leader>r :call SearchAndReplace(1)<CR>
nnoremap <Leader>r :call SearchAndReplace()<CR>

" Alias Ag from fzf.vim to Rg
call SetupCommandAlias("Ag", "Rg")

" ================ plugins setups ========================

let g:fzf_preview_window = ''
let g:fzf_layout = { 'window': 'call FloatingFZF()' }
autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu

let g:airline_powerline_fonts = 1                                               " Enable powerline fonts
let g:airline_theme = "minimalist"                                              " Set theme to powerline default theme
let g:airline_section_y = '%{substitute(getcwd(), expand("$HOME"), "~", "g")}'  " Set relative path
let g:airline#extensions#whitespace#enabled = 0                                 " Disable whitespace extension
let g:airline#extensions#tabline#enabled = 1                                    " Enable tabline extension
let g:airline#extensions#tabline#left_sep = ' '                                 " Left separator for tabline
let g:airline#extensions#tabline#left_alt_sep = '│'                             " Right separator for tabline

let g:gitgutter_enabled = 0
let g:gitgutter_realtime = 0                                                    " Disable gitgutter in realtime
let g:gitgutter_eager = 0                                                       " Disable gitgutter to eager load on tab or buffer switch

let g:user_emmet_expandabbr_key = '<c-e>'                                       " Change trigger emmet key
let g:user_emmet_next_key = '<c-n>'                                             " Change trigger jump to next for emmet

let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

let g:ackhighlight = 1                                                          " Highlight current search
let g:ackprg = 'rg --vimgrep'                                                   " Use ripgrep instead of ack for searching

let g:delimitMate_expand_cr = 1                                                 " auto indent on enter

let g:ale_linters = {'javascript': ['eslint']}                                  " Lint js with eslint
let g:ale_lint_on_save = 1                                                      " Lint when saving a file
let g:ale_sign_error = '✖'                                                      " Lint error sign
let g:ale_sign_warning = '⚠'                                                    " Lint warning sign

let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '                                " Set up spacing for sidebar icons

let g:jsx_ext_required = 1                                                      " Force jsx extension for jsx filetype

let g:indent_guides_enable_on_vim_startup = 0

let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-d>'
let g:multi_cursor_select_all_word_key = '<A-d>'
let g:multi_cursor_start_key           = 'g<C-d>'
let g:multi_cursor_select_all_key      = 'g<A-d>'
let g:multi_cursor_next_key            = '<C-d>'
let g:multi_cursor_prev_key            = '<C-d>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

set nowrap

" ================ coc.nvim setup ========================

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

" Use ctrl+p to trigger fzf for searching for files in the current directory
nnoremap <C-P> :Files <CR>

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Ctrl+R to open outline (requires ctags)
map <c-r> :CocList outline<CR>

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
nmap <silent> gr <Plug>(coc-rename)

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

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

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
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

