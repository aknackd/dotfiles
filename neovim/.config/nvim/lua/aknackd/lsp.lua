local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

-- ************************************
-- Configure LSP
-- ************************************

local nvim_lsp = require('lspconfig')
local on_attach = function (client, bufnr)
    require("completion").on_attach()

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches

local servers = {
    'bashls',        -- Install via `yarn global add bash-language-server`
    'intelephense',  -- Install via `yarn global add intelephense`
    'tsserver',      -- Install via `yarn global add typescript typescript-language-server`
 }

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { on_attach = on_attach }
end
