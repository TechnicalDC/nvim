local nmap = function(lhs, rhs, desc)
  -- See `:h vim.keymap.set()`
  vim.keymap.set('n', lhs, rhs, { desc = desc })
end

local M

M = { window = { config = { border = 'single' } } }

nmap("<leader>ff", "<cmd>lua MiniPick.builtin.files()<cr>", "Open files")

return M
