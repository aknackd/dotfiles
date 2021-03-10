local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local themes = require('telescope.themes')

require('telescope').setup{
    defaults = {
        prompt_prefix = ' > ',
        color_devicons = true,
        sorting_strategy = 'descending',
        scroll_stragety = 'cycle',

        file_sorter = sorters.get_fzy_sorter,

        file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
            },
        }
    }
}
