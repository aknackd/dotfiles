require("Comment").setup {
	padding = true,
	ignore = '^$',
}

local ft = require("Comment.ft")

ft.set("javascript", { "// %s", "/** %s */" })
ft.set("typescript", { "// %s", "/** %s */" })
ft.set("php", { "// %s", "/** %s */" })
