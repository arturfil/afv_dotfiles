-- return {
--     "nvim-neo-tree/neo-tree.nvim",
--     branch = "v3.x",
--     dependencies = {
--         "nvim-lua/plenary.nvim",
--         "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
--         "MunifTanjim/nui.nvim",
--           -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
--     },
--     config = function()
--         vim.keymap.set("n", "<C-n>", "<Cmd>Neotree toggle<CR>")
--     end
-- }
--
-- return {
--     "nvim-tree/nvim-tree.lua",
--     dependencies = { "nvim-tree/nvim-web-devicons" },
--     config = function()
--         local nvimtree = require("nvim-tree")
--
--         vim.g.loaded_netrw = 1
--         vim.g.loaded_netrwPlugin = 1
--
--         nvimtree.setup({})
--
--         vim.keymap.set("n", "<c-n>", ":NvimTreeFindFileToggle<CR>")
--
--     end,
-- }

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local nvimtree = require("nvim-tree")

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			view = {
				width = 30,
				signcolumn = "yes",
			},
			renderer = {
				indent_markers = {
					enable = true,
				},
			},
			-- Add this section to enable window separator
			-- ui = {
			--     border = "single",
			-- },
		})

		vim.keymap.set("n", "<c-n>", ":NvimTreeFindFileToggle<CR>")

		-- Add this to ensure the separator line is visible
		vim.cmd([[
            hi NvimTreeWinSeparator guifg=#444444
        ]])

		-- Keep nvim-tree backgorun in sync with the active theme
		local function sync_nvimtree_bg()
			vim.cmd("hi! link NvimTreeNormal")
			vim.cmd("hi! link NvimTreeNormalNC NormalNC")
			vim.cmd("hi! link NvimTreeEndOfBuffer Normal")
		end

		sync_nvimtree_bg()
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = sync_nvimtree_bg,
		})
	end,
}
