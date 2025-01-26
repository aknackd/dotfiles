local lazy_install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazy_install_path) then
	print("Installing lazy.nvim...")

	local stdout = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazy_install_path,
	})

	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. stdout)
	else
		print("Done!")
	end
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazy_install_path)

require("lazy").setup({
	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		event = "VimEnter",
		config = function()
			require("user.plugins.telescope")
		end,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font, lazy = true },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
		},
	},

	-- [[LSP Plugins]]

	-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
	-- used for completion, annotations and signatures of Neovim apis
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
		dependencies = {
			{ "Bilal2453/luvit-meta", lazy = true },
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
			{ "j-hui/fidget.nvim", opts = {} },
			{ "hrsh7th/cmp-nvim-lsp" },
		},
		config = function()
			require("user.plugins.nvim-lspconfig")
		end,
	},

	-- [[Autoformat]]
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		config = function()
			require("user.plugins.conform")
		end,
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},

	-- [[Autocompletion]]
	{
		"hrsh7th/nvim-cmp",
		event = { "BufReadPost", "BufNewFile", "InsertEnter" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- {
					--   'rafamadriz/friendly-snippets',
					--   config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
					-- },
				},
			},
			{ "saadparwaiz1/cmp_luasnip" },
			{ "onsails/lspkind.nvim" },
		},
		config = function()
			require("user.plugins.nvim-cmp")
		end,
	},

	-- Various UI enhancements
	{
		"nvimdev/lspsaga.nvim",
		branch = "main",
		event = "LspAttach",
		config = function()
			require("user.plugins.lspsaga")
		end,
	},

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	-- Collection of various small independent plugins/modules
	-- {
	-- 	"echasnovski/mini.nvim",
	-- 	config = function()
	-- 		require("user.plugins.mini")
	-- 	end,
	-- },

	-- Highlight, edit, and navigate code,
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("user.plugins.treesitter")
		end,
		dependencies = {
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
			{
				"nvim-treesitter/nvim-treesitter-context",
				config = function()
					require("user.plugins.nvim-treesitter-context")
				end,
			},
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
			{ "nvim-treesitter/playground" },
		},
	},

	{
		"mfussenegger/nvim-lint",
		config = function()
			require("user.plugins.nvim-lint")
		end,
	},

	{
		"akinsho/bufferline.nvim",
		config = function()
			require("user.plugins.bufferline")
		end,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", lazy = true },
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("user.plugins.lualine")
		end,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", lazy = true },
		},
	},

	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	build = function()
	-- 		vim.fn["mkdp#util#install"]()
	-- 	end,
	-- 	config = function()
	-- 		require("user.plugins.markdown-preview")
	-- 	end,
	-- },

	-- {
	-- 	"AndrewRadev/splitjoin.vim",
	-- 	config = function()
	-- 		require("user.plugins.splitjoin")
	-- 	end,
	-- },

	{
		"airblade/vim-gitgutter",
		config = function()
			require("user.plugins.gitgutter")
		end,
	},

	{
		"famiu/bufdelete.nvim",
		config = function()
			require("user.plugins.bufdelete")
		end,
	},

	-- A pretty diagnostics, references, telescope results, quickfix and location list
	{
		"folke/trouble.nvim",
		config = function()
			require("user.plugins.trouble")
		end,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", lazy = true },
		},
	},

	-- Replaces the UI for messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("user.plugins.noice")
		end,
		dependencies = {
			{ "MunifTanjim/nui.nvim" },
			{
				"rcarriga/nvim-notify",
				config = function()
					require("user.plugins.notify")
				end,
			},
		},
	},

	-- {
	-- 	"ray-x/go.nvim",
	-- 	dependencies = {
	-- 		{ "ray-x/guihua.lua" },
	-- 		{
	-- 			"joerdav/templ.vim",
	-- 			config = function()
	-- 				require("user.plugins.templ")
	-- 			end,
	-- 		},
	-- 	},
	-- 	config = function()
	-- 		require("user.plugins.go")
	-- 	end,
	-- 	event = { "CmdlineEnter" },
	-- 	ft = { "go", "gomod" },
	-- 	build = ':lua require("go.install").update_all_sync()',
	-- },

	{
		"ziglang/zig.vim",
		config = function()
			require("user.plugins.zig")
		end,
	},

	-- Git commit browser
	{ "junegunn/gv.vim", dependencies = { "tpope/vim-fugitive" } },

	{
		"junegunn/vim-easy-align",
		config = function()
			require("user.plugins.easy-align")
		end,
	},

	-- Indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("user.plugins.indent-blankline")
		end,
	},

	-- Emmet integration
	{
		"mattn/emmet-vim",
		config = function()
			require("user.plugins.emmet")
		end,
	},

	-- Smart and powerful comment plugin for neovim. Supports treesitter, dot
	-- repeat, left-right/up-down motions, hooks, and more
	{
		"numToStr/Comment.nvim",
		config = function()
			require("user.plugins.comment")
		end,
	},

	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	dependencies = {
	-- 		{ "nvim-tree/nvim-web-devicons", lazy = true },
	-- 	},
	-- 	config = function()
	-- 		require("user.plugins.nvim-tree")
	-- 	end,
	-- },

	-- File explorer
	{
		"stevearc/oil.nvim",
		config = function()
			require("user.plugins.oil")
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Helpers for UNIX (:Remove, :Delete, :Move, etc.)
	{
		"tpope/vim-eunuch",
		config = function()
			require("user.plugins.eunuch")
		end,
	},

	-- {
	-- 	"kana/vim-textobj-user",
	-- 	dependencies = { { "whatyouhide/vim-textobj-xmlattr" } },
	-- },

	-- Provides insert mode auto-completion for quotes, parens, brackets, etc.
	{ "Raimondi/delimitMate" },

	-- Editorconfig integration
	{ "editorconfig/editorconfig-vim" },

	-- Text filtering and alignment
	-- { 'godlygeek/tabular' },

	-- Highlights the matching HTML tag when the cursor is positioned on a tag
	{ "gregsexton/MatchTag" },

	-- Automatically create missing parent directories when saving a new file
	{ "jessarcher/vim-heritage" },

	--  Use RipGrep in Vim and display results in a quickfix list
	{ "jremmen/vim-ripgrep" },

	-- Undo history visualizer
	{ "mbbill/undotree" },

	-- Visually display indent levels
	{ "preservim/vim-indent-guides" },

	-- { 'nelstrom/vim-visual-star-search' },

	-- View status and diff when creating a Git commit
	{ "rhysd/committia.vim" },

	-- Reveal the commit messages under the cursor
	{ "rhysd/git-messenger.vim", lazy = true },

	-- Adds more language packs
	{ "sheerun/vim-polyglot" },

	-- Enable repeating supported plugin maps with "."
	{ "tpope/vim-repeat" },

	-- Delete/change/add parentheses/quotes/XML-tags/much more with ease
	{ "tpope/vim-surround" },

	-- ANSI escape sequences concealed, but highlighted as specified (conceal)
	{ "vim-scripts/AnsiEsc.vim" },

	-- [[Colorschemes]]
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("user.colors.catppucin")
		end,
	},
	{
		"aktersnurra/no-clown-fiesta.nvim",
		config = function()
			require("user.colors.no-clown-fiesta")
		end,
	},
	{ "kristijanhusak/vim-hybrid-material" },
	-- { "yazeed1s/minimal.nvim" },
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will
		-- use the default lazy.nvim defined Nerd Font icons, otherwise define
		-- a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
