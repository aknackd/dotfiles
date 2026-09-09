-- Plugin: vim-gitgutter
-- Description: Show Git diff markers and hunk operations in the sign column.
-- URL: https://github.com/airblade/vim-gitgutter
-- Documentation: https://github.com/airblade/vim-gitgutter/blob/main/doc/gitgutter.txt
-- Required Neovim: Not specified; Vim-compatible.
-- Language: Vimscript
-- Dependencies: Git.
-- User commands: :GitGutterAll, :GitGutter, :GitGutterDisable, :GitGutterEnable, :GitGutterToggle, :GitGutterBufferDisable, :GitGutterBufferEnable, :GitGutterBufferToggle, :GitGutterQuickFix, :GitGutterQuickFixCurrentFile, :GitGutterDiffOrig, :GitGutterLineHighlightsDisable, :GitGutterLineHighlightsEnable, :GitGutterLineHighlightsToggle, :GitGutterLineNrHighlightsDisable, :GitGutterLineNrHighlightsEnable, :GitGutterLineNrHighlightsToggle, :GitGutterSignsEnable, :GitGutterSignsDisable, :GitGutterSignsToggle, :GitGutterNextHunk, :GitGutterPrevHunk, :GitGutterStageHunk, :GitGutterUndoHunk, :GitGutterPreviewHunk, :GitGutterFold, :GitGutterDebug

return {
	"airblade/vim-gitgutter",
	config = function()
		vim.g["gitgutter_enabled"] = 1
		vim.g["gitgutter_realtime"] = 0
		vim.g["gitgutter_eager"] = 0
	end,
}
