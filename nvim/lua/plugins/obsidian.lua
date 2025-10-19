return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- event = {
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/obsidian_vault/arturos_vault",
      },
    },
  },
}
