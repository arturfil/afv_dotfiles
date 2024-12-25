-- enable faster loading
if vim.loader and vim.fn.has("nvim-0.9.1") == 1 then
    vim.loader.enable()
end

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.redrawtime = 1500

-- Disable unused built-in plugins
local disable_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "tarPlugin",
    "zipPlugin",
    "tar",
}

for _, plugin in pairs(disable_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup({
    spec = {
        { import = "plugins" },
        { import = "plugins.lsp" },
    },
    defaults = {
        lazy = false,
    },
    install = { colorscheme = { "catppuccin" } },
    checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = disable_built_ins,
        },
    },
})
