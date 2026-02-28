require("nvim-treesitter.config").setup({
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"css",
		"diff",
		"gitattributes",
		"gitignore",
		"go",
		"html",
		"http",
		"javascript",
		"jsdoc",
		"json",
		"lua",
		"luadoc",
		"make",
		"markdown",
		"markdown_inline",
		"php",
		"phpdoc",
		"python",
		"query",
		"regex",
		"rust",
		"sql",
		"toml",
		"tsx",
		"twig",
		"typescript",
		"vim",
		"vimdoc",
		"vue",
		"yaml",
		"zig",
	},
	highlight = {
		enable = true,
		disable = function(lang, buf)
			local max_filesize = 512 * 1024 -- 512 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		additional_vim_regex_highlighting = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["if"] = "@function.inner",
				["af"] = "@function.outer",
				["ic"] = "@class.inner",
				["ac"] = "@class.outer",
				["ia"] = "@parameter.inner",
				["aa"] = "@parameter.outer",
			},
		},
	},
})

require("ts_context_commentstring").setup({})

vim.g.skip_ts_context_commentstring_module = true

-- require('treesitter-context').setup({
--   enable = true,
--   max_lines = 0,
--   separator = '-',
-- })
