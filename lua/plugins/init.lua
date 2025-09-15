-- Collect every spec in lua/plugins/*.lua (except this file) and return one list
local specs = {}
local root = vim.fn.stdpath("config") .. "/lua/plugins"
local files = vim.fn.globpath(root, "*.lua", false, true) or {}
for _, path in ipairs(files) do
  local mod = path:match("/lua/(.+)%.lua$")
  if mod and mod ~= "plugins/init" then
    local ok, spec = pcall(require, (mod:gsub("/", ".")))
    if ok and spec then
      if type(spec[1]) ~= "nil" then
        vim.list_extend(specs, spec)
      else
        table.insert(specs, spec)
      end
    end
  end
end
return specs
