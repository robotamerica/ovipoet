local state = {}

local function enable(buf)
  -- Enter makes a new poetry line
  vim.keymap.set("i", "<CR>", function()
    return "\n| "
  end, { buffer = buf, expr = true, noremap = true, desc = "PoetryMode: newline with '| '" })

  -- Tab / Shift-Tab for indent/outdent
  vim.keymap.set("i", "<Tab>", "\\quad{}", { buffer = buf, noremap = true, desc = "PoetryMode: indent (LaTeX)" })
  vim.keymap.set("i", "<S-Tab>", "\\qquad{}", { buffer = buf, noremap = true, desc = "PoetryMode: extra indent (LaTeX)" })

  state[buf] = true
  vim.notify("PoetryMode ON", vim.log.levels.INFO)
end

local function disable(buf)
  -- Cleanly remove only PoetryMode’s maps
  for _, key in ipairs({ "<CR>", "<Tab>", "<S-Tab>" }) do
    pcall(vim.keymap.del, "i", key, { buffer = buf })
  end
  state[buf] = nil
  vim.notify("PoetryMode OFF", vim.log.levels.WARN)
end

vim.api.nvim_create_user_command("PoetryMode", function()
  local buf = vim.api.nvim_get_current_buf()
  if state[buf] then disable(buf) else enable(buf) end
end, {})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "org" },
  callback = function(args)
    if vim.bo[args.buf].buftype == "" and vim.bo[args.buf].filetype ~= "gitcommit" then
      enable(args.buf)
    end
  end,
})

vim.keymap.set("n", "<leader>p", ":PoetryMode<CR>", { silent = true, desc = "Toggle PoetryMode" })local state = {}

local function enable(buf)
  -- Enter makes a new poetry line
  vim.keymap.set("i", "<CR>", function()
    return "\n| "
  end, { buffer = buf, expr = true, noremap = true, desc = "PoetryMode: newline with '| '" })

  -- Tab / Shift-Tab for indent/outdent
  vim.keymap.set("i", "<Tab>", "\\quad{}", { buffer = buf, noremap = true, desc = "PoetryMode: indent (LaTeX)" })
  vim.keymap.set("i", "<S-Tab>", "\\qquad{}", { buffer = buf, noremap = true, desc = "PoetryMode: extra indent (LaTeX)" })

  state[buf] = true
  vim.notify("PoetryMode ON", vim.log.levels.INFO)
end

local function disable(buf)
  -- Cleanly remove only PoetryMode’s maps
  for _, key in ipairs({ "<CR>", "<Tab>", "<S-Tab>" }) do
    pcall(vim.keymap.del, "i", key, { buffer = buf })
  end
  state[buf] = nil
  vim.notify("PoetryMode OFF", vim.log.levels.WARN)
end

vim.api.nvim_create_user_command("PoetryMode", function()
  local buf = vim.api.nvim_get_current_buf()
  if state[buf] then disable(buf) else enable(buf) end
end, {})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "org" },
  callback = function(args)
    if vim.bo[args.buf].buftype == "" and vim.bo[args.buf].filetype ~= "gitcommit" then
      enable(args.buf)
    end
  end,
})

vim.keymap.set("n", "<leader>p", ":PoetryMode<CR>", { silent = true, desc = "Toggle PoetryMode" })
