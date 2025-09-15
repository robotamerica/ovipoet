return {
  "uga-rosa/cmp-dictionary",
  dependencies = { "hrsh7th/nvim-cmp" },
  config = function()
    require("cmp_dictionary").setup({
      dic = { ["markdown"] = { "/usr/share/dict/words" } },
      exact_length = 2,       -- (replaces deprecated )
      max_number_items = 15,  -- (replaces deprecated )
    })
  end,
}
