local hues = require("mini.hues")
vim.g.colors_name = "minihues-purple"
local opts = {
  accent = "azure",
  background = "#151025",
  foreground = "#c0c8cb",
}
hues.setup(opts)
-- require("plugins.mini.hues").apply_custom_highlights(opts)
