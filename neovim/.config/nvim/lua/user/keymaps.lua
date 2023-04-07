vim.keymap.set('n', '<C-J>', ':cnext<CR>', { noremap = true, silent = true })      -- Navigate to next item in error list
vim.keymap.set('n', '<C-k>', ':cprev<CR>', { noremap = true, silent = true })      -- Navigate to previous item in error list
vim.keymap.set('t', '<Esc>', '<C-\\><C-n><CR>', { noremap = true })                -- Escape from terminal mode

vim.keymap.set('n', '<Leader><Space>', ':nohlsearch<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>s', ':sort u<CR>', { noremap = true, silent = true })
vim.keymap.set('v', '<Leader>s', ':sort u<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<tab>', '%', { noremap = true })
vim.keymap.set('v', '<tab>', '%', { noremap = true })

vim.keymap.set('v', 'gq', 'gw', { noremap = true })                  -- "gw" seems more consistent than "gq" so always use the former when the latter is used

-- Tab management
vim.keymap.set('n', '<C-t>', ':tabnew<CR>', { noremap = true, silent = true })      -- Open new tab
vim.keymap.set('n', 'tl', ':tabnext<CR>', { noremap = true, silent = true })        -- Jump to next tab
vim.keymap.set('n', 'th', ':tabprevious<CR>', { noremap = true, silent = true })    -- Jump to previous tab
vim.keymap.set('n', '<Leader>c', ':tabclose<CR>', { silent = true })                -- Close tab

-- Stay on the same column with j/k when going up and down within wrapped text
vim.keymap.set('n', 'j', 'v:count == 0 ? "gj" : "j"', { expr = true })
vim.keymap.set('n', 'k', 'v:count == 0 ? "gk" : "k"', { expr = true })

-- Reselect visual mode selection after indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('n', 'q:', ':q')                  -- Remap 'q:' typos to ':q'
vim.keymap.set('v', 'p', '"_dP')                 -- Don't yank selected text when pasting in visual mode
vim.keymap.set('i', ';;', '<Esc>A;')             -- Insert a semicolon at the end of the line when semicolon is pressed twice in insert mode
vim.keymap.set('i', ';;', '<Esc>A;')             -- Insert a semicolon at the end of the line when semicolon is pressed twice in insert mode
vim.keymap.set('n', ';;', '<Esc>A;<Esc>')        -- Same as above but when in normal mode
vim.keymap.set('i', ',,', '<Esc>A,')             -- Insert a comma at the end of the
vim.keymap.set('n', ',,', '<Esc>A,<Esc>')        -- Same as above but when in normal mode;

vim.keymap.set('x', '<leader>p', [["_dP]])
vim.keymap.set('n', '<leader>y', [["+y]])
vim.keymap.set('v', '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Window management
vim.keymap.set('n', 'gh', '<C-W>h', { silent = true })                                     -- Move to window on the left
vim.keymap.set('n', 'gl', '<C-W>l', { silent = true })                                     -- Move to window on the right
vim.keymap.set('n', 'gj', '<C-W>j', { silent = true })                                     -- Move to window below
vim.keymap.set('n', 'gk', '<C-W>k', { silent = true })                                     -- Move to window above
vim.keymap.set('n', '<Leader>w', ':wincmd w<CR>', { silent = true })                       -- Jump to the below/right window of the current window - same as <CTRL-W w>
vim.keymap.set('n', '<Leader>ss', '<Esc>:split<CR>', { noremap = true, silent = true })    -- Open horizontal split
vim.keymap.set('n', '<Leader>sv', '<Esc>:vsplit<CR>', { noremap = true, silent = true })   -- Open vertical split
vim.keymap.set('n', '<Leader>v', '<C-W>v<SPACE>', { noremap = true, silent = true })       -- Open vertical split
vim.keymap.set('n', 'ts', '<Esc>:split<CR>', { noremap = true, silent = true })            -- Open horizontal split
vim.keymap.set('n', 'tv', '<Esc>:vsplit<CR>', { noremap = true, silent = true })           -- Open vertical split
vim.keymap.set('n', '+', '<c-w>5>', { noremap = true })                                    -- Increase window width
vim.keymap.set('n', '-', '<c-w>5<', { noremap = true })                                    -- Decrease window width

vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', 'Q', '<nop>')
