if require "aknackd.first_load"() then
	return
end

vim.g.mapleader = " "

-- Disable providers that we don't need
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

require "aknackd"
