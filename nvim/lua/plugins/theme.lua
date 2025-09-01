return
-- Light Theme
-- {
--          "catppuccin/nvim",
--          name = "catppuccin",
--          lazy = false,
--          priority = 1000,
--          config = function()
--              require("catppuccin").setup({
--                  flavour = "latte",
--              })
--              vim.cmd.colorscheme "catppuccin"
--          end
-- }
-- Current catppuccin Theme
{
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			-- flavour = "latte",
			color_overrides = {
				mocha = {
					-- base = "#181825", -- very dark purple
					-- mantle = "#181825"
					-- base = "#1e1e2e", -- light dark purple
					-- mantle = "#1e1e2e"
					base = "#1b1f20", -- gray black <- THIS
					mantle = "#1b1f20", --           <- THIS
					-- base = "#111111",  -- dark blackl
					-- mantle = "#111111" -- dark blackl
					-- base = "#090d17",
					-- mantle = "#090d17"
				},
			},
			highlight_overrides = {
				mocha = function(colors)
					return {
						-- Change the color of line numbers
						LineNr = { fg = "#808080" },
						CursorLineNr = { fg = colors.mauve }, -- Current line number
					}
				end,
			},
			custom_highlights = {
				WinSeparator = { fg = "#3b4261" },
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
-- {
-- 	"ellisonleao/gruvbox.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		require("gruvbox").setup({
-- 			transparent_mode = false,
-- 			contrast = "hard",
-- 			palette_overrides = {
-- 				bg0 = "#1b1f20", -- Main background
-- 				bg1 = "#1b1f20", -- Darker background (status line)
-- 				bg2 = "#1b1f20", -- Lighter background (line number, folding marks)
-- 				bg3 = "#1b1f20", -- Comments, line highlighting
-- 				bg4 = "#1b1f20", -- Dark foreground
-- 				bg = "#1b1f20",  -- Real bg
-- 			},
-- 			overrides = {
-- 				Normal = { bg = "#1b1f20" },
-- 				NormalFloat = { bg = "#1b1f20" },
-- 				SignColumn = { bg = "#1b1f20" },
-- 			},
-- 		})
-- 		vim.cmd.colorscheme("gruvbox")
-- 	end,
-- 	opts = ...,
-- }
