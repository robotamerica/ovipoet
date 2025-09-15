-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv and vim.uv.fs_stat and vim.uv.fs_stat(lazypath))
  and not (vim.loop and vim.loop.fs_stat and vim.loop.fs_stat(lazypath)) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- 1) Install LazyVim and load its core specs
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- 2) Your plugins (Snacks, Treesitter, Org, Zen/Twilight, Poetry stuff)
    { import = "plugins" },
  },
  defaults = { lazy = false },
  ui = { border = "rounded" },
  change_detection = { enabled = true, notify = false },
})
