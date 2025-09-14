-- Inject Git buttons into dashboard (alpha.nvim preferred, dashboard-nvim fallback)
local ok_alpha, alpha = pcall(require, "alpha")
local ok_theme, dashboard = pcall(require, "alpha.themes.dashboard")

local function inject_alpha_buttons()
  if not (ok_alpha and ok_theme) then return end
  local btn = dashboard.button
  local ours = {
    btn("g p", "  Pull (rebase)", ":PoetryPull<CR>"),
    btn("g P", "  Push",          ":PoetryPush<CR>"),
    btn("g s", "  Sync",          ":PoetrySync<CR>"),
    btn("g S", "  Status",        ":PoetryStatus<CR>"),
  }
  local existing = dashboard.section.buttons.val or {}
  dashboard.section.buttons.val = vim.list_extend(vim.deepcopy(ours), existing)
  pcall(alpha.setup, dashboard.opts)
end

pcall(inject_alpha_buttons)
pcall(vim.api.nvim_create_autocmd, "User", { pattern = "AlphaReady", callback = function() pcall(inject_alpha_buttons) end })

-- Fallback: dashboard-nvim
local ok_dash, dash = pcall(require, "dashboard")
if ok_dash and not ok_alpha then
  dash.setup({
    config = {
      center = {
        { desc = "Pull (rebase)", key = "g p", action = "PoetryPull" },
        { desc = "Push",          key = "g P", action = "PoetryPush" },
        { desc = "Sync",          key = "g s", action = "PoetrySync" },
        { desc = "Status",        key = "g S", action = "PoetryStatus" },
      },
    },
  })
end
