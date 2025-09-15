return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "dictionary" },
          { name = "buffer" },
          { name = "path"   },
        }),
      })
    end,
  },
  {
    "uga-rosa/cmp-dictionary",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("cmp_dictionary").setup({
        dic = {
          markdown = { "/usr/share/dict/words" },
          text     = { "/usr/share/dict/words" },
        },
        exact_length     = 2,   -- replaces deprecated `exact`
        max_number_items = 15,  -- replaces deprecated `max_items`
      })
    end,
  },
}
