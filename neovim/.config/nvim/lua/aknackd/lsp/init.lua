require("aknackd.lsp.servers")
require("aknackd.lsp.keybindings")

require('symbols-outline').setup({
    highlight_hovered_item = true,
    show_guides = true,
})

-- Disable inline text for showing diagnostics, use the keybinding instead
vim.diagnostic.config({
    virtual_text = false,
})
