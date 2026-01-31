local hipatterns    = require('mini.hipatterns')

hipatterns.setup({
   highlighters = {
      fixme = { pattern = 'FIXME:', group = 'MiniHipatternsFixme' },
      todo  = { pattern = 'TODO:',  group = 'MiniHipatternsTodo'  },
      note  = { pattern = 'NOTE:',  group = 'MiniHipatternsNote'  },
      debug = { pattern = 'DEBUG:', group = 'MiniHipatternsDebug'  },

      done     = { pattern = ' DONE ',     group = 'MiniHipatternsDone'  },
      prog     = { pattern = ' PROG ', group = 'MiniHipatternsProgress'  },
      pend     = { pattern = ' PEND ',  group = 'MiniHipatternsPending'  },
      wait     = { pattern = ' WAIT ',     group = 'MiniHipatternsPending'  },
      todo1    = { pattern = ' TODO ',  group = 'MiniHipatternsTodo'  },

      hex_color = hipatterns.gen_highlighter.hex_color(),
   }
})
