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
		map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

		-- Find references for the word under your cursor.
		map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")

		-- Jump to the implementation of the word under your cursor.
		--  Useful when your language has ways of declaring types without an actual implementation.
		map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")

		-- Jump to the type of the word under your cursor.
		--  Useful when you're not sure what type a variable is and you want to see
		--  the definition of its *type*, not where it was *defined*.
		map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")

		-- Fuzzy find all the symbols in your current document.
		--  Symbols are things like variables, functions, types, etc.
		map("<leader>ds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")

		-- Fuzzy find all the symbols in your current workspace.
		--  Similar to document symbols, except searches over your entire project.
		-- map("<leader>ws", require('telescope.builtin').lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

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

		map("[d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, "Go to next diagnostic")
		map("]d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, "Go to previous diagnostic")

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
			map("<leader>tih", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle [I]nlay [H]ints")
		end
	end,
})

require("mason").setup({
	ui = {
		border = "rounded",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = { "lua_ls", "stylua" },
	auto_update = false,
	run_on_start = true,
	start_delay = 3000,
	debounce_hours = 12,
})

utils.create_lsp_cache_dir()

require("user.lsp.emmet-ls")
require("user.lsp.emmet-language-server")
require("user.lsp.html")
require("user.lsp.htmx")
require("user.lsp.intelephense")
require("user.lsp.jdtls")
require("user.lsp.lua_ls")
require("user.lsp.ruby-lsp")
require("user.lsp.tailwindcss")
require("user.lsp.templ")
require("user.lsp.ts_ls")
require("user.lsp.zls")

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
