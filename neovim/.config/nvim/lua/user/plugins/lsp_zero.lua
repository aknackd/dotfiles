local utils = require('user.utils')

if utils.has_feature('lsp') == false then return end

local lsp_zero = require('lsp-zero')
local telescope = require('telescope.builtin')

-- lsp.preset('recommended')
lsp_zero.set_preferences({
    suggest_lsp_servers = false,
    setup_servers_on_start = true,
    set_lsp_keymaps = {
        -- Ignore keymaps that we set ourselves
        omit = { 'gr', 'go', 'gi', 'gl', 'gd', 'gD' },
    },
    configure_diagnostics = true,
    cmp_capabilities = true,
    manage_nvim_cmp = true,
    call_servers = 'local',
})

lsp_zero.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '',
})

-- Ensure that some LSPs are always required via NVIM_LSP_SERVERS
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = utils.get_lsp_servers(),
    handlers = {
      lsp_zero.default_setup,
    },
})

utils.create_lsp_cache_dir()

require('user.plugins.lsp.intelephense')
require('user.plugins.lsp.jdtls')
require('user.plugins.lsp.emmet-ls')

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-f>']     = cmp_action.luasnip_jump_forward(),
        ['<C-b>']     = cmp_action.luasnip_jump_backward(),
        ['<C-u>']     = cmp.mapping.scroll_docs(-4),
        ['<C-d>']     = cmp.mapping.scroll_docs(4),
        ['<C-p>']     = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>']     = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>']     = cmp.mapping.confirm({ select = true }),
        ['<CR>']      = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    })
})
-- lsp_zero.setup_nvim_cmp({
-- 	mapping = cmp_mappings,
-- })

lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	if client.name == 'eslint' then
		vim.cmd.LspStop('eslint')
		return
	end

	vim.keymap.set('n', '<leader>ds', telescope.lsp_document_symbols, opts)
	vim.keymap.set('n', '<leader>rr', telescope.lsp_references, opts)
	vim.keymap.set('n', '<leader>ws', telescope.lsp_workspace_symbols, opts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', 'gi', telescope.lsp_implementations, opts)
	vim.keymap.set('n', '<leader>gr', vim.lsp.buf.rename, opts)
	-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', '<leader>ca',  vim.lsp.buf.code_action, opts)
end)

lsp_zero.setup()

vim.diagnostic.config({
    virtual_text = false,
})
