-- Poetry Git Actions for OviWrite (macOS/Termux)
local function run(cmd, opts)
  opts = opts or {}
  local cwd = opts.cwd or vim.loop.cwd()
  local title = opts.title or cmd
  local out, err = {}, {}
  local id = vim.fn.jobstart(cmd, {
    cwd = cwd, stdout_buffered = true, stderr_buffered = true,
    on_stdout = function(_, d) if d then for _,l in ipairs(d) do if l~="" then table.insert(out,l) end end end end,
    on_stderr = function(_, d) if d then for _,l in ipairs(d) do if l~="" then table.insert(err,l) end end end end,
    on_exit = function(_, code)
      if #out>0 then vim.notify(table.concat(out,"\n"), vim.log.levels.INFO, {title=title}) end
      if #err>0 then vim.notify(table.concat(err,"\n"), vim.log.levels.WARN, {title=title}) end
      if code~=0 then vim.notify(title.." exited with "..code, vim.log.levels.ERROR) else vim.notify(title.." ✓", vim.log.levels.INFO) end
    end
  })
  if id<=0 then vim.notify("Failed to start: "..cmd, vim.log.levels.ERROR) end
end

local function git_root()
  local out = vim.fn.systemlist("git rev-parse --show-toplevel")
  if vim.v.shell_error ~= 0 or not out or #out==0 then
    vim.notify("Not inside a Git repo. cd into your poetry-book folder.", vim.log.levels.ERROR)
    return nil
  end
  return out[1]
end

local M = {}
function M.pull()
  local root = git_root(); if not root then return end
  run("git pull --rebase --autostash", {cwd=root, title="Git Pull"})
end
function M.push()
  local root = git_root(); if not root then return end
  local msg = vim.fn.input("Commit message: "); if msg==nil then return end
  if msg=="" then msg="Update poems" end
  run("sh -lc 'git add -A && (git commit -m " .. vim.fn.shellescape(msg) .. " || true) && git push'", {cwd=root, title="Git Push"})
end
function M.sync()
  local root = git_root(); if not root then return end
  run("git pull --rebase --autostash", {cwd=root, title="Git Pull (rebase)"})
  vim.defer_fn(function()
    run("sh -lc 'git add -A && (git commit -m Sync || true) && git push'", {cwd=root, title="Git Push"})
  end, 300)
end
function M.status()
  local root = git_root(); if not root then return end
  run("git status -s && git branch -vv", {cwd=root, title="Git Status"})
end

vim.api.nvim_create_user_command("PoetryPull", M.pull, {})
vim.api.nvim_create_user_command("PoetryPush", M.push, {})
vim.api.nvim_create_user_command("PoetrySync", M.sync, {})
vim.api.nvim_create_user_command("PoetryStatus", M.status, {})

vim.keymap.set("n", "<leader>gp", M.pull,   {desc="Poetry: Git Pull"})
vim.keymap.set("n", "<leader>gP", M.push,   {desc="Poetry: Git Push"})
vim.keymap.set("n", "<leader>gs", M.sync,   {desc="Poetry: Git Sync"})
vim.keymap.set("n", "<leader>gS", M.status, {desc="Poetry: Git Status"})
