-- Airline configuration
vim.g["airline_powerline_fonts"] = 0
vim.g["airline_theme"] = "minimalist"
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#show_buffers"] = 0
vim.g["airline#extensions#tabline#show_close_button"] = 0
vim.g["airline#extensions#tabline#show_tabs"] = 1
vim.g["airline#extensions#whitespace#enabled"] = 0

-- Editorconfig configuration
vim.g["EditorConfig_exclude_patterns"] = {"fugitive:.*", "scp:.*"}

-- emmet configuration
vim.g["user_emmet_expandabbr_key"] = "<C-e>"
vim.g["user_emmet_next_key"] = "<C-n>"
vim.g["user_emmet_install_global"] = 0

-- airline/vim-gitgutter configuration
vim.g["gitgutter_enabled"] = 1
vim.g["gitgutter_realtime"] = 0
vim.g["gitgutter_eager"] = 0
