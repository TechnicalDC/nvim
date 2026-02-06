local hipatterns    = require('mini.hipatterns')

hipatterns.setup({
   highlighters = {
      fixme = { pattern = 'FIXME:', group = 'MiniHipatternsFixme' },
      todo  = { pattern = 'TODO:',  group = 'MiniHipatternsTodo'  },
      note  = { pattern = 'NOTE:',  group = 'MiniHipatternsNote'  },
      debug = { pattern = 'DEBUG:', group = 'MiniHipatternsDebug'  },

      hex_color = hipatterns.gen_highlighter.hex_color(),
   }
})
