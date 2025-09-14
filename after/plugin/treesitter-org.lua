-- Register a custom parser (per nvim-treesitter "Adding parsers")
-- https://github.com/nvim-treesitter/nvim-treesitter\#adding-parsers
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.org = {
  install_info = {
    url = "https://github.com/nvim-orgmode/tree-sitter-org", -- grammar repo
    files = { "src/parser.c", "src/scanner.c" },  -- <-- .c (not .cc)
    branch = "main",
  },
  filetype = "org",
}
