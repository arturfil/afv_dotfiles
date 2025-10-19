return {
	-- VimTeX: Main LaTeX plugin for Neovim
	{
		"lervag/vimtex",
		lazy = false, -- Load immediately for .tex files
		init = function()
			-- VimTeX configuration
			vim.g.vimtex_view_method = "skim" -- Use Skim on macOS (install with: brew install --cask skim)
			-- Alternative viewers: "zathura", "general", "mupdf"

			-- For Skim, enable auto-refresh
			vim.g.vimtex_view_skim_sync = 1
			vim.g.vimtex_view_skim_activate = 1

			-- Compiler settings
			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_compiler_latexmk = {
				build_dir = "",
				callback = 1,
				continuous = 1,
				executable = "latexmk",
				options = {
					"-pdf",
					"-verbose",
					"-file-line-error",
					"-synctex=1",
					"-interaction=nonstopmode",
				},
			}

			-- Disable overfull/underfull warnings
			vim.g.vimtex_quickfix_ignore_filters = {
				"Underfull",
				"Overfull",
			}

			-- Enable folding
			vim.g.vimtex_fold_enabled = 1
			vim.g.vimtex_fold_types = {
				envs = {
					enabled = 1,
				},
				markers = {
					enabled = 0,
				},
			}

			-- Enable concealment for better math rendering
			vim.g.vimtex_syntax_conceal = {
				accents = 1,
				ligatures = 1,
				cites = 1,
				fancy = 1,
				spacing = 1,
				greek = 1,
				math_bounds = 0,
				math_delimiters = 1,
				math_fracs = 1,
				math_super_sub = 1,
				math_symbols = 1,
				sections = 0,
				styles = 1,
			}

			-- Table of contents configuration
			vim.g.vimtex_toc_config = {
				layer_status = {
					content = 1,
					label = 0,
					todo = 1,
					include = 0,
				},
				show_help = 0,
			}
		end,
		ft = { "tex", "bib" },
	},

	-- Hologram: Preview images in terminal (optional, but great for figures)
	{
		"edluffy/hologram.nvim",
		enabled = false, -- Enable if you want inline image previews
		config = function()
			require("hologram").setup({
				auto_display = true,
			})
		end,
	},

	-- Nabla: Visualize LaTeX equations inline
	{
		"jbyuki/nabla.nvim",
		ft = { "tex", "markdown" },
		keys = {
			{
				"<leader>lp",
				function()
					require("nabla").popup()
				end,
				desc = "LaTeX Preview (Nabla)",
			},
			{
				"<leader>lt",
				function()
					require("nabla").toggle_virt()
				end,
				desc = "LaTeX Toggle Virtual Text",
			},
		},
	},

	-- Markdown rendering (already installed, adding LaTeX-specific config)
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {
			latex = {
				enabled = true,
				converter = "latex2text",
				highlight = "RenderMarkdownMath",
			},
		},
		ft = { "markdown", "tex" },
	},
}
