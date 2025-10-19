-- LaTeX-specific settings
vim.opt_local.conceallevel = 2 -- Enable concealment for better math rendering
vim.opt_local.spell = true -- Enable spell checking
vim.opt_local.wrap = true -- Enable line wrapping for better readability
vim.opt_local.linebreak = true -- Break lines at word boundaries
vim.opt_local.textwidth = 80 -- Recommended width for LaTeX documents
vim.opt_local.colorcolumn = "80" -- Visual guide for line length

-- Indentation settings
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true

-- Key mappings for VimTeX
local keymap = vim.keymap
local opts = { buffer = true, noremap = true, silent = true }

-- Compilation
keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<CR>", vim.tbl_extend("force", opts, { desc = "LaTeX Compile" }))
keymap.set(
	"n",
	"<leader>lc",
	"<cmd>VimtexClean<CR>",
	vim.tbl_extend("force", opts, { desc = "LaTeX Clean aux files" })
)
keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", vim.tbl_extend("force", opts, { desc = "LaTeX View PDF" }))

-- Navigation
keymap.set(
	"n",
	"<leader>ltoc",
	"<cmd>VimtexTocOpen<CR>",
	vim.tbl_extend("force", opts, { desc = "LaTeX Table of Contents" })
)

-- Info and status
keymap.set(
	"n",
	"<leader>li",
	"<cmd>VimtexInfo<CR>",
	vim.tbl_extend("force", opts, { desc = "LaTeX Info" })
)
keymap.set(
	"n",
	"<leader>ls",
	"<cmd>VimtexStatus<CR>",
	vim.tbl_extend("force", opts, { desc = "LaTeX Status" })
)

-- Errors and logs
keymap.set(
	"n",
	"<leader>le",
	"<cmd>VimtexErrors<CR>",
	vim.tbl_extend("force", opts, { desc = "LaTeX Errors" })
)
keymap.set("n", "<leader>lo", "<cmd>VimtexLog<CR>", vim.tbl_extend("force", opts, { desc = "LaTeX Log" }))

-- Stop compilation
keymap.set(
	"n",
	"<leader>lk",
	"<cmd>VimtexStop<CR>",
	vim.tbl_extend("force", opts, { desc = "LaTeX Stop compilation" })
)
