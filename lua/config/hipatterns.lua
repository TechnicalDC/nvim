local hipatterns    = require('mini.hipatterns')

hipatterns.setup({
   highlighters = {
      fixme = { pattern = 'FIXME:', group = 'MiniHipatternsFixme' },
      todo  = { pattern = 'TODO:',  group = 'MiniHipatternsTodo'  },
      note  = { pattern = 'NOTE:',  group = 'MiniHipatternsNote'  },
      debug = { pattern = 'DEBUG:', group = 'MiniHipatternsDebug'  },

      done     = { pattern = ' DONE ',     group = 'MiniHipatternsDone'  },
      progress = { pattern = ' PROGRESS ', group = 'MiniHipatternsProgress'  },
      pending  = { pattern = ' PENDING ',  group = 'MiniHipatternsPending'  },
      wait     = { pattern = ' WAIT ',     group = 'MiniHipatternsPending'  },

      hex_color = hipatterns.gen_highlighter.hex_color(),
   }
})

-- Disable only for certain filetypes (for example, "lua" and "help")
vim.api.nvim_create_autocmd('Filetype', {
   pattern = { "org" },
   callback = function(args)
      vim.b[args.buf].miniindentscope_disable = true
   end
})
