P = function (v)
    print(vim.inspect(v))
    return v
end

RELOAD = function (...)
    return require("plenary.reload").reload_module(...)
end

R = function (name)
    RELOAD(name)
    return require(name)
end

map = function (key)
    -- get the extra options
    local opts = {noremap = true}
    for i, v in pairs(key) do
        if type(i) == "string" then opts[i] = v end
    end

    -- basic support for buffer-scoped keybindings
    local buffer = opts.buffer
    opts.buffer = nil

    if buffer then
        vim.api.nvim_buf_set_keymap(0, key[1], key[2], key[3], opts)
    else
        vim.api.nvim_set_keymap(key[1], key[2], key[3], opts)
    end
end

buf_set_option = function (...)
    vim.api.nvim_buf_set_option(bufnr, ...)
end

create_augroup = function (name, autocmds)
    vim.cmd('augroup ' .. name)
    vim.cmd('autocmd!')
    for _, autocmd in ipairs(autocmds) do
        vim.cmd('autocmd ' .. table.concat(autocmd, ' '))
    end
    vim.cmd('augroup END')
end

aknackd_enable_spellcheck = function ()
	vim.api.nvim_win_set_option(0, "spell", true)
end
