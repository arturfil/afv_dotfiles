return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
			"mfussenegger/nvim-dap-vscode-js",
			"mfussenegger/nvim-dap-python",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			-- Setup Debug Adapters

			-- Go configuration
			require("dap-go").setup()

			-- Python configuration
			require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")

			-- TypeScript/Node configuration
			dap.adapters.node2 = {
				type = "executable",
				command = "node",
				args = {
					vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js",
				},
			}

			dap.configurations.typescript = {
				{
					name = "TypeScript: ts-node",
					type = "node2",
					request = "launch",
					program = "${workspaceFolder}/node_modules/.bin/ts-node",
					args = { "${file}" },
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					console = "integratedTerminal",
					-- outFiles not strictly needed here, but can still be helpful for sourcemap resolution
					-- outFiles = { "${workspaceFolder}/**/*.ts" }
				},
				{
					name = "TypeScript: ts-node-dev Server",
					type = "node2",
					request = "launch",
					runtimeExecutable = "${workspaceFolder}/node_modules/.bin/ts-node-dev", -- Use ts-node-dev for hot-reload
					-- runtimeArgs = { "--inspect", "--transpile-only" }, -- Adjust args for your setup
					-- args = { "${workspaceFolder}/src/app.ts" }, -- Entry point of your server
                    runtimeArgs = { "--inspect", "--transpile-only", "--require", "tsconfig-paths/register" },
					args = function()
						-- Prompt user to input the entry file or select dynamically
						local entry = vim.fn.input("Path to entry file: ", "src/index.ts", "file")
						return { entry }
					end,
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					console = "integratedTerminal",
					restart = true, -- Automatically reconnect debugger after restart
					outFiles = { "${workspaceFolder}/src/**/*.ts" },
				},

				{
					name = "TypeScript: Jest Current File",
					type = "node2",
					request = "launch",
					program = "${workspaceFolder}/node_modules/.bin/jest",
					args = { "${file}" },
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					console = "integratedTerminal",
					outFiles = { "${workspaceFolder}/dist/**/*.js" },
				},
			}

			-- Optionally, you can mirror these settings for "javascript" if needed
			dap.configurations.javascript = dap.configurations.typescript

			-- UI Configuration
			require("dapui").setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
				mappings = {
					-- Use a table to apply multiple mappings
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				-- Expand lines larger than the window
				-- Requires >= 0.7
				expand_lines = vim.fn.has("nvim-0.7") == 1,
				layouts = {
					{
						elements = {
							-- Elements can be strings or table with id and size keys.
							{ id = "scopes", size = 0.25 },
							"breakpoints",
							"stacks",
							"watches",
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							"repl",
							"console",
						},
						size = 0.25,
						position = "bottom",
					},
				},
				controls = {
					enabled = true,
					-- Display controls in this element
					element = "repl",
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "↓",
						step_over = "→",
						step_out = "↑",
						step_back = "←",
						run_last = "↻",
						terminate = "□",
					},
				},
				floating = {
					max_height = nil,
					max_width = nil,
					border = "single",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
			})

			-- Automatically open UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Set up signs
			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "", numhl = "" })

			-- Keymaps
			vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "Debug: Toggle UI" })
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Debug: Set Conditional Breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Continue" })
			vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Debug: Run to Cursor" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Debug: Step Out" })
			vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Debug: Toggle REPL" })
			vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Debug: Run Last" })
			vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "Debug: Terminate" })
			vim.keymap.set("n", "<leader>dR", function()
				dapui.open({ reset = true })
			end, { desc = "Debug: Reset UI" })
		end,
	},
}
