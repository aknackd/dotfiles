local nvim_lsp = require('lspconfig')
local on_attach = function (client, bufnr)
    require("aknackd.lsp.completion")

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches

local servers = {
    'bashls',        -- Install via `yarn global add bash-language-server`
    'intelephense',  -- Install via `yarn global add intelephense`
    'tsserver',      -- Install via `yarn global add typescript typescript-language-server`
 }

 -- Setup lspconfig
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
            debouncee_text_changes = 150,
        },
    }
end

-- Go to definitions in a split window
-- Taken from https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#go-to-definition-in-a-split-window
local function goto_definition(split_cmd)
  local util = vim.lsp.util
  local log = require("vim.lsp.log")
  local api = vim.api

  -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
  local handler = function(_, result, ctx)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, "No location found")
      return nil
    end

    if split_cmd then
      vim.cmd(split_cmd)
    end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1])

      if #result > 1 then
        util.set_qflist(util.locations_to_items(result))
        api.nvim_command("copen")
        api.nvim_command("wincmd p")
      end
    else
      util.jump_to_location(result)
    end
  end

  return handler
end

vim.lsp.handlers["textDocument/definition"] = goto_definition('vsplit')
