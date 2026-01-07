local misc = require('mini.misc')            
local nmap = function(lhs, rhs, desc)
  -- See `:h vim.keymap.set()`
  vim.keymap.set('n', lhs, rhs, { desc = desc })
end

misc.setup()
misc.setup_restore_cursor()

nmap("<leader>tz", "<cmd>lua MiniMisc.zoom()<cr>", "Toggle zoom")
