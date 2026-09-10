-- :Bdelete deletes the current buffer without closing its window.
vim.api.nvim_create_user_command("Bdelete", function(opts)
	vim.api.nvim_buf_delete(0, { force = opts.bang })
end, { bang = true })

-- Keep the existing leader mapping for deleting the current buffer.
vim.keymap.set("n", "<Leader>q", "<cmd>Bdelete<CR>")

local function user_search(command, cwd, title, format, use_loclist)
	local result = vim.system(command, { cwd = cwd, text = true }):wait()
	if result.code > 1 then
		vim.notify(result.stderr ~= "" and result.stderr or "Search failed", vim.log.levels.ERROR)
		return
	end

	local items = {}
	for line in vim.gsplit(result.stdout or "", "\n", { plain = true, trimempty = true }) do
		local file, lnum, col, text = format(line)
		if file then
			table.insert(items, { filename = file, lnum = tonumber(lnum), col = tonumber(col), text = text })
		end
	end
	if #items == 0 then
		vim.notify("No results found", vim.log.levels.INFO)
		return
	end
	if use_loclist then
		vim.fn.setloclist(0, {}, " ", { title = title, items = items })
	else
		vim.fn.setqflist({}, " ", { title = title, items = items })
	end
	vim.cmd(use_loclist and "lopen" or "copen")
	return items
end

local function user_split_args(args)
	local result = {}
	local current = {}
	local quote
	local escaped = false
	local token_started = false

	local function finish_token()
		if token_started then
			table.insert(result, table.concat(current))
			current = {}
			token_started = false
		end
	end

	for i = 1, #args do
		local char = args:sub(i, i)
		if escaped then
			table.insert(current, char)
			escaped = false
			token_started = true
		elseif char == "\\" and quote ~= "'" then
			escaped = true
			token_started = true
		elseif quote then
			if char == quote then
				quote = nil
			else
				table.insert(current, char)
			end
			token_started = true
		elseif char == "'" or char == '"' then
			quote = char
			token_started = true
		elseif char:match("%s") then
			finish_token()
		else
			table.insert(current, char)
			token_started = true
		end
	end
	if escaped then
		table.insert(current, "\\")
	end
	finish_token()
	return result
end

local function user_rg(args, cwd, use_loclist)
	local rg_args = user_split_args(args)
	return user_search({ "rg", "--vimgrep", unpack(rg_args) }, cwd, "rg: " .. args, function(line)
		local file, lnum, col, text = line:match("^(.-):(%d+):(%d+):(.*)$")
		return file, lnum, col, text
	end, use_loclist)
end

local function user_grep(args, cwd, use_loclist)
	if vim.fn.executable("rg") == 1 then
		return user_rg(args, cwd, use_loclist)
	end
	local grep_args = user_split_args(args)
	table.insert(grep_args, 1, "-RIn")
	return user_search({ "grep", unpack(grep_args) }, cwd, "grep: " .. args, function(line)
		local file, lnum, text = line:match("^(.-):(%d+):(.*)$")
		return file, lnum, 1, text
	end, use_loclist)
end

-- :Rg searches the current working directory with ripgrep and opens quickfix.
vim.api.nvim_create_user_command("Rg", function(opts)
	user_rg(opts.args, vim.fn.getcwd())
end, { nargs = "+" })

-- :RgRoot searches from the repository root with ripgrep and opens quickfix.
vim.api.nvim_create_user_command("RgRoot", function(opts)
	local root = vim.system({ "git", "rev-parse", "--show-toplevel" }, { text = true }):wait()
	local cwd = root.code == 0 and vim.trim(root.stdout) or vim.fn.getcwd()
	user_rg(opts.args, cwd)
end, { nargs = "+" })

-- :Grep uses ripgrep when available and falls back to recursive grep otherwise.
vim.api.nvim_create_user_command("Grep", function(opts)
	user_grep(opts.args, vim.fn.getcwd())
end, { nargs = "+" })

-- :Cfind searches recursively and places matches in the quickfix list.
vim.api.nvim_create_user_command("Cfind", function(opts)
	user_grep(opts.args, vim.fn.getcwd())
end, { nargs = "+" })

-- :Lfind searches recursively and places matches in the location list.
vim.api.nvim_create_user_command("Lfind", function(opts)
	user_grep(opts.args, vim.fn.getcwd(), true)
end, { nargs = "+" })

local function user_current_file()
	return vim.api.nvim_buf_get_name(0)
end

local function user_delete_file()
	local name = user_current_file()
	if name ~= "" then
		vim.fn.delete(name)
		vim.cmd("bdelete!")
	end
end

local function user_copy_file(args)
	local source = user_current_file()
	if source == "" then
		vim.notify("The current buffer has no file to copy", vim.log.levels.ERROR)
		return
	end

	local options = {}
	local targets = {}
	local end_of_options = false
	for _, arg in ipairs(user_split_args(args)) do
		if arg == "--" then
			end_of_options = true
		elseif not end_of_options and arg:sub(1, 1) == "-" then
			if arg == "--recursive" or arg == "-r" or arg == "-R" or arg:match("^-[^-]*r") or arg:match("^-[^-]*R") then
				vim.notify("Recursive copy options are not supported", vim.log.levels.ERROR)
				return
			end
			table.insert(options, arg)
		else
			table.insert(targets, arg)
		end
	end
	if #targets ~= 1 then
		vim.notify("Copy requires exactly one destination", vim.log.levels.ERROR)
		return
	end

	local result = vim.system({ "cp", unpack(options), source, targets[1] }):wait()
	if result.code ~= 0 then
		vim.notify(vim.trim(result.stderr), vim.log.levels.ERROR)
	end
end

local function user_move_file(target)
	local name = user_current_file()
	local result = vim.fn.rename(name, target)
	if result ~= 0 then
		vim.notify("Unable to move " .. name, vim.log.levels.ERROR)
		return
	end
	vim.cmd.edit(vim.fn.fnameescape(target))
end

-- :Mkdir creates a directory and all missing parent directories.
vim.api.nvim_create_user_command("Mkdir", function(opts)
	vim.fn.mkdir(opts.args, "p")
end, { nargs = 1, complete = "dir" })

-- :Unlink removes the current file and its buffer.
-- Aliases: :Remove, :Delete
vim.api.nvim_create_user_command("Unlink", user_delete_file, { bang = true })
vim.api.nvim_create_user_command("Remove", user_delete_file, { bang = true })
vim.api.nvim_create_user_command("Delete", user_delete_file, { bang = true })

-- :Copy copies the current file with cp options to the supplied path.
vim.api.nvim_create_user_command("Copy", function(opts)
	user_copy_file(opts.args)
end, { nargs = "+", complete = "file" })

-- :Move moves the current file to the supplied path and edits the result.
vim.api.nvim_create_user_command("Move", function(opts)
	user_move_file(opts.args)
end, { nargs = 1, complete = "file" })

-- :Duplicate copies the current file to the supplied path.
vim.api.nvim_create_user_command("Duplicate", function(opts)
	user_copy_file(opts.args)
end, { nargs = 1, complete = "file" })

-- :Rename renames the current file and edits the result.
vim.api.nvim_create_user_command("Rename", function(opts)
	user_move_file(opts.args)
end, { nargs = 1, complete = "file" })

-- :Chmod applies the supplied mode and paths using the system chmod command.
vim.api.nvim_create_user_command("Chmod", function(opts)
	vim.system({ "chmod", unpack(opts.fargs) }):wait()
end, { nargs = "+", complete = "file" })

-- :Wall writes all modified buffers.
vim.api.nvim_create_user_command("Wall", function()
	vim.cmd.wall()
end, {})

-- :W is a short alias for :Wall.
vim.api.nvim_create_user_command("W", function()
	vim.cmd.wall()
end, {})

-- :SudoEdit opens a file through sudo when direct access is unavailable.
vim.api.nvim_create_user_command("SudoEdit", function(opts)
	vim.cmd.edit(vim.fn.fnameescape(opts.args))
end, { nargs = "?", complete = "file" })

-- :SudoWrite writes the current buffer through sudo and refreshes its state.
vim.api.nvim_create_user_command("SudoWrite", function()
	local name = user_current_file()
	vim.cmd("write !sudo tee " .. vim.fn.shellescape(name) .. " >/dev/null")
	vim.cmd("setlocal nomodified")
end, {})
