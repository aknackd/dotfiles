require('lualine').setup({
    options = {
        -- icons_enabled = true,
        theme = 'codedark',
        component_separators = '',
        section_separators = '',
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = {
            'mode',
        },
        lualine_b = {
            'branch',
            'diff',
            '" " .. tostring(#vim.tbl_keys(vim.lsp.buf_get_clients()))',
            'diagnostics',
        },
        lualine_c = {
            { 'filename', path = 1, shorting_target = 0 },
        },
        lualine_x = {
            'encoding',
            { 'filetype', icons_enabled = true, icon_only = false, colored = true },
        },
        lualine_y = { '(vim.bo.expandtab and "␠ " or "⇥ ") .. " " .. vim.bo.shiftwidth' },
        lualine_z = { 'location', 'progress' },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {
        -- lualine_a = { 'buffers' },
        -- lualine_b = {},
        -- lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        -- lualine_z = { 'tabs' },
    },
    winbar = {},
    inactive_winbar = {},
    extensions = {},
})
