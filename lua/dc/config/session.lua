local nmap = function(lhs, rhs, desc)
  -- See `:h vim.keymap.set()`
  vim.keymap.set('n', lhs, rhs, { desc = desc })
end

nmap( "<leader>ss", "<cmd>mksession!<cr>", "Create session (local)" )
nmap( "<leader>so", "<cmd>lua MiniSessions.select()<cr>", "Open session" )
nmap( "<leader>sw", "<cmd>lua MiniSessions.write()<cr>", "Write session" )
nmap( "<leader>sS", function ()
   local session_dir = vim.fn.stdpath("data") .. "/session/"
   vim.ui.input({ prompt = 'Session name' }, function(session_name)
      if vim.fn.filereadable(session_dir .. session_name) == 0 then
         vim.cmd("mksession! " .. session_dir .. session_name)
      end
   end)
end, "Create session (global)" )

require('mini.sessions').setup({
	file = '.Session.vim',
})
