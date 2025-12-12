return {
	-- Oasis light theme
	{
		"uhs-robert/oasis.nvim",
		lazy = false,
		priority = 1001,
		config = function()
			require("oasis").setup({
				-- Configure for light theme by default when activated
			})
		end,
	},

	-- GitHub theme
	{
		"projekt0n/github-nvim-theme",
		lazy = false,
		priority = 998,
		config = function()
			require("github-theme").setup({
				options = {
					transparent = false,
					terminal_colors = true,
					dim_inactive = false,
					module_default = true,
					styles = {
						comments = "italic",
						keywords = "bold",
						types = "italic,bold",
					},
				},
			})
		end,
	},

	-- Catppuccin theme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			-- Store the full configuration
			local catppuccin_config = {
				flavour = "mocha",
				color_overrides = {
					mocha = {
						base = "#1b1f20", -- gray black
						mantle = "#1b1f20",
					},
				},
				highlight_overrides = {
					mocha = function(colors)
						return {
							-- Change the color of line numbers
							LineNr = { fg = "#808080" },
							CursorLineNr = { fg = colors.mauve }, -- Current line number

							-- VSCode-like diagnostic colors (more subtle)
							DiagnosticError = { fg = colors.red },
							DiagnosticWarn = { fg = colors.yellow },
							DiagnosticInfo = { fg = colors.sky },
							DiagnosticHint = { fg = colors.teal },

							-- Underline colors (subtle, like VSCode)
							DiagnosticUnderlineError = { undercurl = true, sp = colors.red },
							DiagnosticUnderlineWarn = { undercurl = true, sp = colors.yellow },
							DiagnosticUnderlineInfo = { undercurl = true, sp = colors.sky },
							DiagnosticUnderlineHint = { undercurl = true, sp = colors.teal },

							-- Virtual text (dimmed, not in-your-face)
							DiagnosticVirtualTextError = { fg = colors.red, bg = "NONE", italic = true },
							DiagnosticVirtualTextWarn = { fg = "#7a6a3d", bg = "NONE", italic = true },
							DiagnosticVirtualTextInfo = { fg = colors.sky, bg = "NONE", italic = true },
							DiagnosticVirtualTextHint = { fg = colors.teal, bg = "NONE", italic = true },
						}
					end,
					latte = function(colors)
						return {
							-- Line numbers for light mode
							LineNr = { fg = "#6c6f85" },
							CursorLineNr = { fg = colors.mauve },

							-- Diagnostic colors for light mode
							DiagnosticError = { fg = colors.red },
							DiagnosticWarn = { fg = colors.yellow },
							DiagnosticInfo = { fg = colors.blue },
							DiagnosticHint = { fg = colors.teal },

							-- Underline colors
							DiagnosticUnderlineError = { undercurl = true, sp = colors.red },
							DiagnosticUnderlineWarn = { undercurl = true, sp = colors.yellow },
							DiagnosticUnderlineInfo = { undercurl = true, sp = colors.blue },
							DiagnosticUnderlineHint = { undercurl = true, sp = colors.teal },

							-- Virtual text
							DiagnosticVirtualTextError = { fg = colors.red, bg = "NONE", italic = true },
							DiagnosticVirtualTextWarn = { fg = colors.yellow, bg = "NONE", italic = true },
							DiagnosticVirtualTextInfo = { fg = colors.blue, bg = "NONE", italic = true },
							DiagnosticVirtualTextHint = { fg = colors.teal, bg = "NONE", italic = true },
						}
					end,
				},
				custom_highlights = {
					WinSeparator = { fg = "#3b4261" },
				},
			}

			require("catppuccin").setup(catppuccin_config)

			-- Set Catppuccin as default theme
			vim.cmd.colorscheme("catppuccin")

			-- Initialize current theme tracker
			vim.g.current_theme = "catppuccin"

			-- Theme toggle function
			_G.toggle_theme = function()
				if vim.g.current_theme == "catppuccin" then
					-- Set background to light before applying oasis
					vim.o.background = "light"
					-- Try to set Oasis, fallback to github_light if not available
					local success = pcall(vim.cmd.colorscheme, "oasis")
					if success then
						vim.g.current_theme = "oasis"
						print("Switched to Oasis Light")
					else
						vim.cmd.colorscheme("github_light")
						vim.g.current_theme = "github_light"
						print("Switched to GitHub Light (Oasis not available)")
					end
					-- Also toggle tmux theme to solarized light
					vim.fn.system("tmux set -g @colors-solarized 'light' && tmux source-file ~/.tmux.conf")
				else
					-- Set background to dark before applying catppuccin
					vim.o.background = "dark"
					vim.cmd.colorscheme("catppuccin")
					vim.g.current_theme = "catppuccin"
					-- Also toggle tmux theme to dark
					vim.fn.system("tmux set -g @catppuccin_flavour 'mocha' && tmux set -g @catppuccin_status_background '#1b1f20' && tmux source-file ~/.tmux.conf")
					print("Switched to Catppuccin Dark")
				end
			end

			-- Create keymap for theme toggle
			vim.keymap.set("n", "<leader>tt", _G.toggle_theme, { desc = "Toggle between Oasis Light and Catppuccin Dark" })
		end,
	},
}

