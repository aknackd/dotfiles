local utils = require("user.utils")

require("no-clown-fiesta").setup({
	transparent = utils.does_colorscheme_has_transparent_background(),
})

vim.opt.listchars = { space = "·", tab = "▸ ", trail = "·" }
