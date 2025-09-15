return {
  {
    "folke/zen-mode.nvim",
    opts = {
      window = { backdrop = 0.95, width = 0.6, options = { number = false, relativenumber = false } },
      plugins = { gitsigns = true, tmux = false, kitty = false },
    },
  },
  {
    "folke/twilight.nvim",
    opts = { context = 1, expand = { "function", "method", "table", "if_statement" } },
  },
}
