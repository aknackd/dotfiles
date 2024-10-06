local utils = require("user.utils")

local colorscheme = utils.get_colorscheme()

vim.opt.termguicolors = true
vim.opt.syntax = "on"
vim.opt.background = utils.get_background()

vim.g.colors_name = colorscheme
vim.cmd('let g:colors_name = "' .. colorscheme .. '"')
vim.cmd.colorscheme(colorscheme)

if colorscheme == "hybrid_reverse" then
	vim.cmd("let g:hybrid_transparent_background = 1")
end
