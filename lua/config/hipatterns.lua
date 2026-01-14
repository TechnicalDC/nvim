local hipatterns    = require('mini.hipatterns')

hipatterns.setup({
   highlighters = {
      fixme = { pattern = ' FIXME ', group = 'MiniHipatternsFixme' },
      hack  = { pattern = ' HACK ',  group = 'MiniHipatternsHack'  },
      todo  = { pattern = ' TODO ',  group = 'MiniHipatternsTodo'  },
      note  = { pattern = ' NOTE ',  group = 'MiniHipatternsNote'  },
      debug = { pattern = ' DEBUG ', group = 'MiniHipatternsHack'  },

      done     = { pattern = 'DONE',  group     = 'MiniHipatternsDone'  },
      progress = { pattern = 'PROGRESS',  group = 'MiniHipatternsProgress'  },
      pending  = { pattern = 'PENDING',  group  = 'MiniHipatternsPending'  },

      hex_color = hipatterns.gen_highlighter.hex_color(),
   }
})
