-- OVIWrite main init
-- Order matters: options -> keymaps -> lazy bootstrap
pcall(require, "config.options")
pcall(require, "config.keymaps")
require("config.lazy")      -- sets up Lazy and loads specs from lua/plugins
pcall(require, "config.globals")
