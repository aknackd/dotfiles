local lsp = require("user.lsp")

local format = function()
	if vim.bo.filetype == "templ" then
		local templ = utils.find_in_path("templ")
		if templ == nil then
			return
		end

		local bufnr = vim.api.nvim_get_current_buf()
		local filename = vim.api.nvim_buf_get_name(bufnr)
		local cmd = vim.fn.shellescape(templ) .. " fmt " .. vim.fn.shellescape(filename)

		vim.fn.jobstart(cmd, {
			on_exit = function()
				-- Reload the buffer only if it's still the current buffer
				if vim.api.nvim_get_current_buf() == bufnr then
					vim.cmd("e!")
				end
			end,
		})
	else
		vim.lsp.buf.format()
	end
end

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	vim.keymap.set("n", "<leader>lf", format, opts)
end

lsp.setup("templ", {
	on_attach = on_attach,
	filetypes = { "html", "templ" },
})

vim.filetype.add({ extension = { templ = "templ" } })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.templ" },
	callback = format,
})
