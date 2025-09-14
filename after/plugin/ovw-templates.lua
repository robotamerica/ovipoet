local ok, mod = pcall(require, "ovw.writer_templates")
if not ok then return end
-- Prefer module's own picker if present; fallback builds one.
local pick = mod.select_template
if type(pick) ~= "function" then
  local function insert_template(tpl)
    local lines = vim.split(tpl.content, "\n")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  end
  pick = function()
    local items, keys = {}, {}
    for k, v in pairs(mod.templates or {}) do
      table.insert(items, (v.name or k) .. " (" .. k .. ")")
      table.insert(keys, k)
    end
    vim.ui.select(items, { prompt = "Insert Template" }, function(_, idx)
      if not idx then return end
      insert_template(mod.templates[keys[idx]])
    end)
  end
end
vim.api.nvim_create_user_command("TemplatePick", pick, { desc = "Insert a document template" })
