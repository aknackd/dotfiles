local templ = require('user.plugins.templ')

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	vim.keymap.set("n", "<leader>lf", templ.format, opts)
end

require('lspconfig').templ.setup({
    on_attach = on_attach,
    filetypes = { "html", "templ" },
})

