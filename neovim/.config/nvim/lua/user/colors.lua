local utils = require('user.utils')

-- Extract the colorscheme from the NVIM_COLORSCHEME environment variable (fallback to "default")
local colorscheme = 'default'
local parts = utils.split(':', utils.get_colorscheme())
if #parts == 2 then colorscheme = parts[2] end

-- @@@ Check if module exists
local config = require('user.plugins.colors.'..colorscheme)

-- 1) Add any global variables defined in the theme
if utils.has_key(config, 'settings') then
	for k, v in pairs(config.settings) do vim.g[k] = v end
end

-- 2) Apply the colorscheme
vim.opt.background = config.background or 'dark'
vim.g.colors_name = colorscheme
vim.cmd('let g:colors_name = "'..colorscheme..'"')
vim.cmd.colorscheme(colorscheme)

-- 3) And finally apply any highlight overrides
if utils.has_key(config, 'highlights') then
	for _, v in ipairs(config.highlights) do
		vim.api.nvim_set_hl(0, v['group'], v['options'])
	end
end
