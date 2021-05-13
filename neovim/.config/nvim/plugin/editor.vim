nmap <leader>c gcc                          " Comment map
xmap <leader>c gc                           " Line comment command
nmap ga <Plug>(EasyAlign)                   " vim-easy-align
xmap ga <Plug>(EasyAlign)                   " vim-easy-align
nnoremap <leader><space> :nohls<CR>         " Clear search highlight
nnoremap <tab> >>                           " Tab to indent in normal mode
nnoremap <s-tab> <<                         " Shift+Tab to de-indent in normal mode
xnoremap <tab> >gv                          " Tab to indent in visual mode
xnoremap <s-tab> <gv                        " Shift+Tab to de-indent in visual mode
vnoremap <C-s-c> "+y                        " Copy to system clipboard
vnoremap J :m '>+1<CR>gv=gv                 " Move selected line(s) down
vnoremap K :m '<-2<CR>gv=gv                 " Move selected line(s) up

" -- Autocommands
augroup vimrc
    autocmd!
augroup END

autocmd vimrc BufWritePre * :call s:StripTrailingWhitespaces()   " Auto-remove trailing spaces
autocmd vimrc InsertEnter * :set nocul                           " Remove cursorline highlight
autocmd vimrc InsertLeave * :set cul                             " Add cursorline highlight in normal mode

function! s:StripTrailingWhitespaces()
    let l:l = line(".")
    let l:c = col(".")
    %s/\s\+$//e
    call cursor(l:l, l:c)
endfunction

