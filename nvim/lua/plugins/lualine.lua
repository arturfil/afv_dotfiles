return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin",
				section_separators = { left = "", right = "" },
				sections = {
					lualine_a = {
						{ "mode", separator = { left = "" }, right_padding = 2 },
					},
					lualine_b = {
						{ "%f" },
						{ "branch", "diff", "diagnostics" },
					},
					lualine_c = {
						{ "%f" },
					},
					lualine_x = {
						{ "filename", path = 1 },
					},
					lualine_y = { "filetype", "progress" },
					lualine_z = {
						{ "location", separator = { right = "" }, left_padding = 2 },
					},
				},
			},
		})
		vim.opt.laststatus = 3 -- Global status line
		vim.opt.splitbelow = true -- Force all horizontal splits to go below current window
		vim.opt.splitright = true -- Force all vertical splits to go to the right of current window
		vim.opt.fillchars = {
			horiz = "━",
			horizup = "┻",
			horizdown = "┳",
			vert = "┃",
			vertleft = "┨",
			vertright = "┣",
			verthoriz = "╋",
			eob = " ", -- Remove the '~' at the end of buffer
		}
	end,
}
