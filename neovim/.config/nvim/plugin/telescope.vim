lua require('aknackd')

nnoremap <C-P> <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <C-T> <cmd>lua require('telescope.builtin').git_files()<CR>
nnoremap <C-F> <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <C-G> <cmd>lua require('telescope.builtin').git_commits()<CR>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<CR>
