vim.cmd("packadd packer.nvim")
vim.cmd("packadd vimball")

local has = function (x)
    return vim.fn.has(x) == 1
end

local is_wsl = (function ()
    local output = vim.fn.systemlist "uname -r"
    return not not string.find(output[1] or "", "WSL")
end)()

return require("packer").startup(function ()
    use "wbthomason/packer.nvim"

    use "Raimondi/delimitMate"
    use "airblade/vim-gitgutter"
    use "editorconfig/editorconfig-vim"
    use "godlygeek/tabular"
    use "gregsexton/MatchTag"
    use { "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function () vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" } }
    use "jremmen/vim-ripgrep"
    use "junegunn/gv.vim"
    use "junegunn/vim-easy-align"
    use "lbrayner/vim-rzip"
    use { "lukas-reineke/indent-blankline.nvim", buftype_exclude = { "terminal" }, show_end_of_line = true }
    use "mattn/emmet-vim"
    use "nathanaelkane/vim-indent-guides"
    use "nelstrom/vim-visual-star-search"
    use "ntpeters/vim-better-whitespace"
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use "rhysd/committia.vim"
    use "rhysd/git-messenger.vim"
    use "sheerun/vim-polyglot"
    use "simrat39/symbols-outline.nvim"
    use "tpope/vim-commentary"
    use "tpope/vim-fugitive"
    use "tpope/vim-repeat"
    use "tpope/vim-surround"
    use "tpope/vim-eunuch"
    use "vim-airline/vim-airline"
    use "vim-airline/vim-airline-themes"
    use "vim-scripts/AnsiEsc.vim"

    -- LSP Plugins
    use "neovim/nvim-lspconfig"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use "hrsh7th/nvim-cmp"
    use "tjdevries/lsp_extensions.nvim"
    use "tjdevries/nlua.nvim"

    -- telescope.nvim
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-fzy-native.nvim"

    -- Themes
    use "kristijanhusak/vim-hybrid-material"
    use "morhetz/gruvbox"
end)
