vim.opt.title = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.history = 500                                  -- Store lots of :cmdline history
vim.opt.showcmd  = true                                -- Show incomplete commands down the bottom
vim.opt.showmode = false                               -- Hide showmode because of powerline
vim.opt.gdefault = true                                -- Set global flag for search and replace
vim.opt.gcr = "a:blinkon500-blinkwait500-blinkoff500"  -- Set cursor blink rate
vim.opt.cursorline = true                              -- Highlight current line
vim.opt.hlsearch = true                                -- Highlight search results
vim.opt.incsearch = true
vim.opt.smartcase = true                               -- Smart case search if there is uppercase
vim.opt.ignorecase = true                              -- Case insensitive search
vim.opt.mouse = "c"                                    -- Enable mouse usage
vim.opt.showmatch = true                               -- Highlight matching bracket
vim.opt.startofline = false                            -- Jump to first non-blank character
vim.opt.timeoutlen = 250                               -- Reduce command timeout for faster escape
vim.opt.ttimeoutlen = 100                              -- Reduce command timeout for faster escape
vim.opt.fileencoding = "utf-8"                         -- Set UTF-8 encoding on write
vim.opt.wrap = false                                   -- Disable word wrap
vim.opt.linebreak = true                               -- Wrap lines at convenient points
vim.opt.list = true                                    -- Enable listchars
vim.opt.listchars = {
	space = "·",
	tab = "▸ ",
	trail = "·",
	eol = "↴",
}
vim.opt.lazyredraw = true                              -- Do not redraw on registers and macros
vim.opt.completeopt:append("menuone")
vim.opt.completeopt:append("noselect")
vim.opt.completeopt:remove("preview")                  -- Disable preview for autocomplate
vim.opt.hidden = true                                  -- Hide buffers in background
vim.opt.splitbelow = true                              -- Setup new horizontal splits below
vim.opt.splitright = true                              -- Setup new vertical splits to the right
vim.opt.scrolloff = 8
vim.opt.sidescrolloff=8
vim.opt.path:append("**")                              -- Allow recursive search
vim.opt.inccommand = "split"                           -- Show substitute changes immediately
vim.opt.cmdheight = 1
vim.opt.updatetime = 250

vim.opt.swapfile = false                               -- Don't write a swap file
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.opt.undofile = true

vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.foldenable = false
vim.opt.wrap = false
