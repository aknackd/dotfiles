let s:bundle_dir = expand('~/.config/nvim/bundle')
let s:plugin_dir = s:bundle_dir . '/repos/github.com'

call plug#begin('~/.config/nvim/plugged')
    Plug 'Raimondi/delimitMate'
    Plug 'airblade/vim-gitgutter'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'godlygeek/tabular'
    Plug 'gregsexton/MatchTag'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
    Plug 'jremmen/vim-ripgrep'
    Plug 'junegunn/gv.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'lbrayner/vim-rzip'
    Plug 'mattn/emmet-vim', { 'for': 'blade,html,vue' }
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'nelstrom/vim-visual-star-search'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'rhysd/committia.vim'
    Plug 'rhysd/git-messenger.vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'simrat39/symbols-outline.nvim'
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
    Plug 'tjdevries/lsp_extensions.nvim'
    Plug 'tjdevries/nlua.nvim'

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

let mapleader = ' '

