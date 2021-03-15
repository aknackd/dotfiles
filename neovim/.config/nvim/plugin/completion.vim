inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"     " Move to next tab completion item
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"   " Move to previous tab completion item"
set completeopt=menuone,noinsert,noselect
set shortmess+=c
let g:completion_matching_strategy_list = ['fuzzy', 'exact', 'substring', 'all']
