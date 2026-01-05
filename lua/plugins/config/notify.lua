local miniNotify = require('mini.notify')

miniNotify.setup({
   window = {
      config = {
         title = ""
      }
   }
})

vim.notify = miniNotify.make_notify()
