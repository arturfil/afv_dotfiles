-- lua/core/ui.lua
local function build_statuscolumn()
	local space = " "
	local align = "%="
	local num = "%{v:relnum ? v:relnum : v:lnum}" -- Show relative line numbers when enabled
	local git = "%s" -- Show git signs
	local diagnostics = "%{%v:lua.require'core.ui'.diagnostic_signs()%}" -- Show diagnostic signs

	return table.concat({ align, num, space, git, diagnostics })
end

-- Function to get diagnostic signs
local function diagnostic_signs()
	local bufnr = vim.api.nvim_get_current_buf()
	local line = vim.fn.line(".") - 1
	local diagnostics = vim.diagnostic.get(bufnr, { lnum = line })

	if #diagnostics == 0 then
		return " "
	end

	local highest_severity = diagnostics[1].severity
	for _, diagnostic in ipairs(diagnostics) do
		if diagnostic.severity < highest_severity then
			highest_severity = diagnostic.severity
		end
	end

	local signs = {
		[vim.diagnostic.severity.ERROR] = "󰅚",
		[vim.diagnostic.severity.WARN] = "",
		[vim.diagnostic.severity.INFO] = "",
		[vim.diagnostic.severity.HINT] = "󰌶",
	}

	return signs[highest_severity] or " "
end

-- Setup function
local function setup()
	-- Set up the statuscolumn
	vim.opt.statuscolumn = build_statuscolumn()

	-- Enhanced UI settings
	vim.opt.number = true
	vim.opt.relativenumber = true
	vim.opt.cursorline = true
	vim.opt.signcolumn = "yes"
	vim.opt.colorcolumn = "80"

	-- Smooth scrolling
	vim.opt.scrolloff = 8
	vim.opt.sidescrolloff = 8

	-- Better splits
	vim.opt.splitbelow = true
	vim.opt.splitright = true

	-- Set up diagnostic signs
	local signs = {
		Error = " ",
		Warn = " ",
		Hint = "󰌶 ",
		Info = " ",
	}
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end
end

return {
	setup = setup,
	diagnostic_signs = diagnostic_signs,
}
