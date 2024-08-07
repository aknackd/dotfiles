local utils = require('user.utils')

local lazy_install_path = vim.fn.stdpath('data')..'/lazy/lazy.nvim'

-- Install lazy.nvim if it isn't already installed
if not vim.loop.fs_stat(lazy_install_path) then
    print('Installing lazy.nvim ...')
    vim.fn.system({
        'git', 'clone', '--filter=blob:none', '--branch=stable',
        'https://github.com/folke/lazy.nvim.git',
        lazy_install_path,
    })
    print('Done')
end

vim.opt.rtp:prepend(lazy_install_path)

require('lazy').setup {
    {
        'nvim-telescope/telescope.nvim',
        branch       = 'master',
        config       = function() require('user.plugins.telescope') end,
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-tree/nvim-web-devicons', lazy = true },
            { 'nvim-telescope/telescope-live-grep-args.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build        = ':TSUpdate',
        config       = function() require('user.plugins.treesitter') end,
        dependencies = {
            { 'JoosepAlviste/nvim-ts-context-commentstring' },
            -- { 'nvim-treesitter/nvim-treesitter-context' },
            { 'nvim-treesitter/nvim-treesitter-textobjects' },
            { 'nvim-treesitter/playground' },
         },
    },

    {
        'VonHeikemen/lsp-zero.nvim',
        config       = function() require('user.plugins.lsp_zero') end,
        dependencies = {
            -- LSP Support
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'neovim/nvim-lspconfig' },

            -- Autocompletion
            { 'saadparwaiz1/cmp_luasnip' },
            {
                'hrsh7th/nvim-cmp',
                event = 'InsertEnter',
                dependencies = {
                    { 'hrsh7th/cmp-buffer' },
                    { 'hrsh7th/cmp-nvim-lsp' },
                    { 'hrsh7th/cmp-nvim-lua' },
                    { 'hrsh7th/cmp-path' },
                },
            },

            -- Snippets
            {
                'L3MON4D3/LuaSnip',
                version = 'v2.*',
                build = 'make install_jsregexp',
            },
            { 'rafamadriz/friendly-snippets' },

            -- Miscellaneous
            { 'simrat39/symbols-outline.nvim' },
        },
    },

    {
        'nvimdev/lspsaga.nvim',
        branch = 'main',
        event = 'LspAttach',
        config = function() require('user.plugins.lspsaga') end,
    },

    {
        'sbdchd/neoformat',
        config = function () require('user.plugins.neoformat') end,
    },

    {
        'mfussenegger/nvim-lint',
        config = function () require('user.plugins.nvim-lint') end,
    },

    {
        'akinsho/bufferline.nvim',
        config       = function() require('user.plugins.bufferline') end,
        dependencies = {
            { 'nvim-tree/nvim-web-devicons', lazy = true },
        },
    },

    {
        'nvim-lualine/lualine.nvim',
        config       = function() require('user.plugins.lualine') end,
        dependencies = {
            { 'nvim-tree/nvim-web-devicons', lazy = true },
        },
    },

    -- {
    --     'lewis6991/gitsigns.nvim',
    --     config       = function() require('user.plugins.gitsigns') end,
    --     dependencies = { 'nvim-lua/plenary.nvim' },
    -- },

    {
        'iamcco/markdown-preview.nvim',
        build  = function() vim.fn['mkdp#util#install']() end,
        config = function() require('user.plugins.markdown-preview') end,
    },

    {
        'AndrewRadev/splitjoin.vim',
        config = function() require('user.plugins.splitjoin') end,
    },

    {
        'airblade/vim-gitgutter',
        config = function() require('user.plugins.gitgutter') end,
    },

    {
        'famiu/bufdelete.nvim',
        config = function() require('user.plugins.bufdelete') end,
    },

    {
        'folke/trouble.nvim',
        config = function() require('user.plugins.trouble') end,
        dependencies = {
            { 'nvim-tree/nvim-web-devicons', lazy = true },
        },
    },

    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        config = function() require('user.plugins.noice') end,
        dependencies = {
            { 'MunifTanjim/nui.nvim' },
            { 'rcarriga/nvim-notify', config = function() require ('user.plugins.notify') end },
        },
    },

    {
        'joerdav/templ.vim',
        config = function() require('user.plugins.templ') end,
    },

    {
        'junegunn/gv.vim',
        dependencies = { 'tpope/vim-fugitive' },
    },

    {
        'junegunn/vim-easy-align',
        config = function() require('user.plugins.easy-align') end,
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        config = function () require('user.plugins.indent-blankline') end,
    },

    {
        'mattn/emmet-vim',
        config = function() require('user.plugins.emmet') end,
    },

    {
        'numToStr/Comment.nvim',
        config = function() require('user.plugins.comment') end,
    },

    -- {
    --     'nvim-tree/nvim-tree.lua',
    --     dependencies = {
    --         { 'nvim-tree/nvim-web-devicons', lazy = true },
    --     },
    --     config = function () require('user.plugins.nvim-tree') end,
    -- },

    {
        'stevearc/oil.nvim',
        config = function() require('user.plugins.oil') end,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },

    {
        'tpope/vim-eunuch',
        config = function() require('user.plugins.eunuch') end,
    },

    {
        'kana/vim-textobj-user',
        dependencies = { { 'whatyouhide/vim-textobj-xmlattr' } },
    },

    { 'Raimondi/delimitMate' },
    { 'editorconfig/editorconfig-vim' },
    { 'godlygeek/tabular' },
    { 'gregsexton/MatchTag' },
    { 'jessarcher/vim-heritage' },
    { 'jremmen/vim-ripgrep' },
    { 'mbbill/undotree' },
    { 'nathanaelkane/vim-indent-guides' },
    { 'nelstrom/vim-visual-star-search' },
    { 'rhysd/committia.vim' },
    { 'rhysd/git-messenger.vim' },
    { 'sheerun/vim-polyglot' },
    { 'tpope/vim-repeat' },
    { 'tpope/vim-surround' },
    { 'vim-scripts/AnsiEsc.vim' },

    utils.use_colorscheme_plugin('kristijanhusak/vim-hybrid-material'),
    utils.use_colorscheme_plugin('romainl/apprentice'),
    utils.use_colorscheme_plugin('yazeed1s/minimal.nvim'),
    utils.use_colorscheme_plugin('rebelot/kanagawa.nvim'),
    utils.use_colorscheme_plugin('luisiacc/gruvbox-baby'),
    utils.use_colorscheme_plugin('morhetz/gruvbox'),
}
