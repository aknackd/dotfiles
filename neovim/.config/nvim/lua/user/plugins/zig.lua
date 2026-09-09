-- Plugin: zig.vim
-- Description: Syntax highlighting, indentation, and tooling integration for Zig.
-- URL: https://github.com/ziglang/zig.vim
-- Documentation: https://github.com/ziglang/zig.vim#readme
-- Required Neovim: Not specified; Vim-compatible.
-- Language: Vimscript
-- Dependencies: Zig compiler for formatting/compiler integration.
-- User commands: None (provides the :compiler zig compiler definition).

return {
	"ziglang/zig.vim",
	config = function()
		vim.g.zig_fmt_parse_errors = 0
		vim.g.zig_fmt_autosave = 0

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.zig", "*.zon" },
			callback = function(ev)
				vim.lsp.buf.format()
			end,
		})
	end,
}
