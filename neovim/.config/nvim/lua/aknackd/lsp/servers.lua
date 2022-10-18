local nvim_lsp = require('lspconfig')
local on_attach = function (client, bufnr)
    require("aknackd.lsp.completion")
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches

local servers = {
    'bashls',        -- Install via `yarn global add bash-language-server`
    'intelephense',  -- Install via `yarn global add intelephense`
    'tsserver',      -- Install via `yarn global add typescript typescript-language-server`
    'volar',         -- Install via `yarn global add @volar/vue-language-server`
 }

 -- Setup lspconfig
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
    }
end
