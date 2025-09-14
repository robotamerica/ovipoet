-- ~/.config/oviwrite/lua/plugins/smear_cursor.lua
return {
  "sphamba/smear-cursor.nvim",
  main = "smear_cursor",
  lazy = false,              -- load at startup (not on-events)
  priority = 1000,           -- load early; safe with themes
  init = function()
    vim.opt.termguicolors = true
  end,
  opts = {
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    scroll_buffer_space = true,
    smear_insert_mode = true,
    cursor_color = "#ff8800",
    stiffness = 0.3,
    trailing_stiffness = 0.1,
    damping = 0.5,
    trailing_exponent = 5,
    never_draw_over_target = true,
    hide_target_hack = true,
    gamma = 1,
  },
  config = function(_, opts)
    -- lazy will call setup(opts) automatically because of `main`,
    -- but calling explicitly is harmless & future-proof:
    require("smear_cursor").setup(opts)
    require("smear_cursor").enabled = true
  end,
}
