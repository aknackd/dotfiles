local M = {}

function M.setup(server_name, opts)
	opts = opts or {}

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

	opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, opts.capabilities or {})

	vim.lsp.config(server_name, opts)
	vim.lsp.enable(server_name)
end

return M
