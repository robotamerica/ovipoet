return {
  { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "lua","vim","vimdoc","bash","json","regex",
        "markdown","markdown_inline","latex"
      },
      auto_install = true,
    },
  },
  { "nvim-orgmode/orgmode",
    ft = { "org" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("orgmode").setup({})
    end,
  },
}
