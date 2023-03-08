
local utils = require('user.utils')
local use_colorscheme_plugin = utils.use_colorscheme_plugin

local ensure_packer = function ()
	local directory = vim.fn.stdpath('data')..'/site/pack/packer/start'
	local install_path = directory..'/packer.nvim'

    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        print('Installing packer.nvim ...')
        vim.fn.mkdir(directory, 'p')
        vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        print('Done')
        vim.cmd.packadd('packer.nvim')
        return true
    end

    return false
end

local packer_bootstrap = ensure_packer()

local packer = require('packer')

-- Initialize packer
packer.init({
	compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
    config = {
        profile = {
            enable = true,
        },
    },
	display = {
		open_fn = function()
			return require('packer.util').float({ border = 'rounded' })
		end,
	},
})

-- Automatically install plugins on first run
if packer_bootstrap then
	packer.sync()
end

-- Automatically regenerate compiled loader file on save
-- @@@ Convert to lua
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile>
	augroup end
]])

return packer.startup(function (use)
    use('wbthomason/packer.nvim')

    use({ 'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'nvim-telescope/telescope-live-grep-args.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        },
        config = function() require('user.plugins.telescope') end,
    })

    use({ 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = {
            'JoosepAlviste/nvim-ts-context-commentstring',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/playground',
        },
        config = function() require('user.plugins.treesitter') end,
    })

    use({ 'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',

            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',

            -- Snippets
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',

            -- Miscellaneous
            'simrat39/symbols-outline.nvim',
        },
        config = function() require('user.plugins.lsp') end,
    })

    use({ 'glepnir/lspsaga.nvim',
        branch = "main",
        config = function() require('user.plugins.lspsaga') end,
    })

    -- use({ 'vim-airline/vim-airline',
    --     requires = { { 'vim-airline/vim-airline-themes' } },
    --     config = function() require('user.plugins.airline') end,
    -- })

    use({ 'akinsho/bufferline.nvim',
        requires = {
            'nvim-lualine/lualine.nvim',
            { 'kyazdani42/nvim-web-devicons', opt = true },
        },
        config = function() require('user.plugins.bufferline') end,
    })

    use({ 'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function() require('user.plugins.gitsigns') end,
    })

    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
        config = function() require('user.plugins.markdown-preview') end,
    })

    use({ 'AndrewRadev/splitjoin.vim', config = function() require('user.plugins.splitjoin') end })
    -- use({ 'airblade/vim-gitgutter', config = function() require('user.plugins.gitgutter') end })
    use({ 'famiu/bufdelete.nvim', config = function() require('user.plugins.bufdelete') end })
    use({ 'folke/trouble.nvim', config = function() require('user.plugins.trouble') end })
    use({ 'junegunn/gv.vim', requires = { 'tpope/vim-fugitive' } })
    use({ 'junegunn/vim-easy-align', config = function() require('user.plugins.easy-align') end })
    use({ 'lukas-reineke/indent-blankline.nvim', config = function () require('user.plugins.indent-blankline') end })
    use({ 'mattn/emmet-vim', config = function() require('user.plugins.emmet') end })
    use({ 'numToStr/Comment.nvim', config = function() require('user.plugins.comment') end })
    use({ 'rcarriga/nvim-notify', config = function() require('user.plugins.notify') end })
    use({ 'tpope/vim-eunuch', config = function() require('user.plugins.eunuch') end })
    use({ 'whatyouhide/vim-textobj-xmlattr', requires = { { 'kana/vim-textobj-user' } } })

    use('Raimondi/delimitMate')
    use('editorconfig/editorconfig-vim')
    use('godlygeek/tabular')
    use('gregsexton/MatchTag')
    use('jessarcher/vim-heritage')          -- Automatically create parent directories when saving
    use('jremmen/vim-ripgrep')
    use('mbbill/undotree')
    use('nathanaelkane/vim-indent-guides')
    use('nelstrom/vim-visual-star-search')
    use('rhysd/committia.vim')
    use('rhysd/git-messenger.vim')
    use('sheerun/vim-polyglot')
    use('tpope/vim-repeat')
    use('tpope/vim-surround')
    use('vim-scripts/AnsiEsc.vim')

    -- Colorschemes

    use_colorscheme_plugin(use, 'kristijanhusak/vim-hybrid-material', {})
    use_colorscheme_plugin(use, 'jessarcher/onedark.nvim', {})
    use_colorscheme_plugin(use, 'romainl/apprentice', {})
    use_colorscheme_plugin(use, 'yazeed1s/minimal.nvim', {})
    use_colorscheme_plugin(use, 'rebelot/kanagawa.nvim', {})
    use_colorscheme_plugin(use, 'luisiacc/gruvbox-baby', {})
    use_colorscheme_plugin(use, 'morhetz/gruvbox', {})
end)
