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
require('user.plugins.lsp.templ')

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
    vim.keymap.set('n', '[d', vim.diagnostic.goto_next, utils.mergetable(opts, { desc = 'Go to next diagnostic' }))
    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, utils.mergetable(opts, { desc = 'Go to previous diagnostic '}))
    vim.keymap.set('n', 'gi', telescope.lsp_implementations, opts)
    vim.keymap.set('n', '<leader>gr', vim.lsp.buf.rename, utils.mergetable(opts, { desc = 'Rename variable/function/method under cursor' }))
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, utils.mergetable(opts, { desc = 'Open floating diagnostic message' }))
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, utils.mergetable(opts, { desc = 'Open diagnostic list' }))
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, utils.mergetable(opts, { desc = 'Open code actions' }))
end)

lsp_zero.setup()

vim.diagnostic.config({
    -- Don't show diagnostics as virtual text at the end of the line (use <leader>e or <leader>q defined above)
    virtual_text = false,
})

-- Truncate the LSP log file
vim.api.nvim_create_user_command('LspLogTruncate', function ()
    local filename = vim.fn.stdpath('state')..'/lsp.log'
    if utils.file_exists(filename) then
        io.open(filename, 'w'):close()
        vim.notify('Truncated LSP log file')
    end
end, {})
