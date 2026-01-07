local starter = require('mini.starter')
local autocmd = vim.api.nvim_create_autocmd
local map     = vim.keymap.set
local opts    = { buffer = true }

starter.setup({
   header = function()
      local banner = [[

                 █              █

████████████ ███ ████████ ███
██████████████ ████ ██████████ ████
█████ ████ █████ ████ █████ █████ ████
█████ ████ █████ ████ █████ █████ ████
█████ ████ ████████ █████ ████████
      ]]
      return banner
    end,
    footer = "",
    items = {
       { name = 'find files', action = 'Pick files', section = 'Section' },
       { name = 'browse files', action = 'lua require("mini.files").open(vim.uv.cwd(), true)', section = 'Section' },
       { name = 'recent files', action = "lua MiniExtra.pickers.oldfiles()", section = 'Section' },
       { name = 'load session', action = "lua MiniSessions.select()", section = 'Section' },
       { name = 'edit new buffer', action = 'enew', section = 'Builtin actions' },
       { name = 'quit Neovim', action = 'qall', section = 'Builtin actions' },
    },
    content_hooks = {
       starter.gen_hook.adding_bullet(),
       -- starter.gen_hook.indexing('all'),
       starter.gen_hook.aligning('center', 'center'),
    },
    query_updaters = [[abcdefghilmoqrstuvwxyz0123456789_-,.ABCDEFGHIJKLMOQRSTUVWXYZ]],
})

autocmd("User",{
   pattern = "MiniStarterOpened",
   callback = function(args)
      map("n", "j", "<Cmd>lua MiniStarter.update_current_item('next')<CR>", opts)
      map("n", "k", "<Cmd>lua MiniStarter.update_current_item('prev')<CR>", opts)
      map("n", "<C-p>", "<Cmd>Telescope find_files<CR>", opts)
      map("n", "<C-n>", "<Cmd>Telescope file_browser<CR>", opts)
   end
})
