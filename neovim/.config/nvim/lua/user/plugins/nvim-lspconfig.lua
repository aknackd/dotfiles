local builtin = require("telescope.builtin")
local utils = require("user.utils")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- Jump to the definition of the word under your cursor.
		--  This is where a variable was first declared, or where a function is defined, etc.
		--  To jump back, press <C-t>.
		map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")

		-- Find references for the word under your cursor.
		map("gr", builtin.lsp_references, "[G]oto [R]eferences")

		-- Jump to the implementation of the word under your cursor.
		--  Useful when your language has ways of declaring types without an actual implementation.
		map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")

		-- Jump to the type of the word under your cursor.
		--  Useful when you're not sure what type a variable is and you want to see
		--  the definition of its *type*, not where it was *defined*.
		map("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")

		-- Fuzzy find all the symbols in your current document.
		--  Symbols are things like variables, functions, types, etc.
		map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")

		-- Fuzzy find all the symbols in your current workspace.
		--  Similar to document symbols, except searches over your entire project.
		map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

		-- Rename the variable under your cursor.
		--  Most Language Servers support renaming across files, etc.
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

		-- Execute a code action, usually your cursor needs to be on top of an error
		-- or a suggestion from your LSP for this to activate.
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

		-- Display a floating diagnostic message when virtual text is hidden
		-- or the message is too long to see without scrolling
		map("<leader>e", vim.diagnostic.open_float, "[O]pen [f]loating [d]iagnostic message")

		-- WARN: This is not Goto Definition, this is Goto Declaration.
		--  For example, in C this would take you to the header.
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		map("[d", vim.diagnostic.goto_next, "Go to next diagnostic")
		map("]d", vim.diagnostic.goto_prev, "Go to previous diagnostic")

		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		--    See `:help CursorHold` for information about when this is executed
		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		-- The following code creates a keymap to toggle inlay hints in your
		-- code, if the language server you are using supports them
		--
		-- This may be unwanted, since they displace some of your code
		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

-- LSP servers and clients are able to communicate to each other what features they support.
--  By default, Neovim doesn't support everything that is in the LSP specification.
--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

-- Enable the following language servers, they will automatically be installed.
--
--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
local servers = {
	["emmet-ls"] = require("user.lsp.emmet-ls"),
	["emmet_language_server"] = require("user.lsp.emmet-language-server"),
	["html"] = require("user.lsp.html"),
	["htmx"] = require("user.lsp.htmx"),
	["intelephense"] = require("user.lsp.intelephense"),
	["jdtls"] = require("user.lsp.jdtls"),
	["lua_ls"] = require("user.lsp.lua_ls"),
	["tailwindcss"] = require("user.lsp.tailwindcss"),
	["templ"] = require("user.lsp.templ"),
	["tsserver"] = require("user.lsp.ts_ls"),
}

require("mason").setup({
	ui = {
		border = "rounded",
	},
})

local ensure_installed = utils.get_lsp_servers()
vim.list_extend(ensure_installed, { "stylua" })

require("mason-tool-installer").setup({
	ensure_installed = ensure_installed,
	auto_update = false,
	run_on_start = true,
	start_delay = 3000,
	debounce_hours = 12,
})

require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}

			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})

			-- INFO: 2024-09-07 - tsserver was renamed to ts_ls
			-- INFO: https://github.com/neovim/nvim-lspconfig/commit/bdbc65aadc708ce528efb22bca5f82a7cca6b54d
			if server_name == "tsserver" then
				server_name = "ts_ls"
			end

			require("lspconfig")[server_name].setup(server)
		end,
	},
})

utils.create_lsp_cache_dir()

require("lspconfig.ui.windows").default_options.border = "rounded"

vim.diagnostic.config({
	float = { border = "rounded" },
	-- Don't show diagnostics as virtual text at the end of the
	-- line (use "<leader>e" defined above)
	-- virtual_text = false,
})

-- Truncate the LSP log file
vim.api.nvim_create_user_command("LspLogTruncate", function()
	local filename = vim.fn.stdpath("state") .. "/lsp.log"
	if utils.file_exists(filename) then
		io.open(filename, "w"):close()
		vim.notify("Truncated LSP log file")
	end
end, {})
