-- Plugin: nvim-cmp
-- Description: Completion engine with extensible completion sources.
-- URL: https://github.com/hrsh7th/nvim-cmp
-- Documentation: https://github.com/hrsh7th/nvim-cmp#readme
-- Required Neovim: >= 0.8.0.
-- Language: Lua
-- Dependencies: cmp-nvim-lsp, cmp-buffer, cmp-path, cmp-nvim-lsp-signature-help, LuaSnip, cmp_luasnip, lspkind.nvim; make and a C compiler for LuaSnip/jsregexp when built.
-- User commands: :CmpStatus

return {
	"hrsh7th/nvim-cmp",
	event = { "BufReadPost", "BufNewFile", "InsertEnter" },
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {},
		},
		{ "saadparwaiz1/cmp_luasnip" },
		{ "onsails/lspkind.nvim" },
	},
	config = function()
		---@diagnostic disable: missing-fields

		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		luasnip.config.setup({})

		cmp.setup({

			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			completion = { completeopt = "menu,menuone,noinsert" },

			-- For an understanding of why these mappings were
			-- chosen, you will need to read `:help ins-completion`
			--
			-- No, but seriously. Please read `:help ins-completion`, it is really good!
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				-- Accept ([y]es) the completion.
				--  This will auto-import if your LSP supports it.
				--  This will expand snippets if the LSP sent a snippet.
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<CR>"] = cmp.mapping.confirm({ select = true }),

				-- Manually trigger a completion from nvim-cmp.
				--  Generally you don't need this, because nvim-cmp will display
				--  completions whenever it has completion options available.
				["<C-Space>"] = cmp.mapping.complete({}),

				-- Think of <c-l> as moving to the right of your snippet expansion.
				--  So if you have a snippet that's like:
				--  function $name($args)
				--    $body
				--  end
				--
				-- <c-l> will move you to the right of each of the expansion locations.
				-- <c-h> is similar, except moving you backwards.
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),

				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),

				-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
			}),

			sources = {
				{ name = "lazydev", group_index = 0 },
				{ name = "nvim_lsp", group_index = 1 },
				{ name = "buffer", max_item_count = 5, group_index = 2 },
				{ name = "path", max_item_count = 3, group_index = 3 },
				{ name = "luasnip", max_item_count = 3, group_index = 5 },
				{ name = "nvim-lsp-signature-help" },
			},

			formatting = {
				expandable_indicator = true,
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
					ellipsis_char = "...",
					menu = {
						nvim_lsp = "[LSP]",
						buffer = "[Buffer]",
						path = "[PATH]",
						luasnip = "[LuaSnip]",
					},
				}),
			},
		})
	end,
}
