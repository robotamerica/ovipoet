return {
  {
    "nvim-orgmode/orgmode",
    ft = { "org" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("orgmode").setup({
        -- keep it simple; no setup_ts_grammar(), no org parser
      })
    end,
  },
}
