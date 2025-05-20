local ls = require("luasnip")

-- Load Go snippets
local go_snippets = require("snippets.go")
ls.add_snippets("go", go_snippets)

-- You can add more snippet languages here as needed
-- ls.add_snippets("python", require("snippets.python"))
-- ls.add_snippets("javascript", require("snippets.javascript"))

-- Reload snippets on save of snippet files
vim.cmd([[
  augroup luasnip_reload
    autocmd!
    autocmd BufWritePost */snippets/*.lua lua require("luasnip").cleanup(); require("luasnip").refresh()
  augroup END
]]) 