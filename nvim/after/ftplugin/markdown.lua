-- Disable indent guides/lines in markdown files
vim.opt_local.list = false
vim.opt_local.listchars = ""

-- Disable concealment of markdown syntax
vim.opt_local.conceallevel = 0

-- Ensure treesitter doesn't add visual indent markers
vim.b.indent_blankline_enabled = false
