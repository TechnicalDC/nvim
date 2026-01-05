return { 
   'nvim-mini/mini.nvim', 
   version = false, 
   config = function() 
      require("plugins.config.pick")
      require("plugins.config.clue")
      require("plugins.config.diff")
      require("plugins.config.files")
      require("plugins.config.icons")
      require("plugins.config.indentscope")
      require("plugins.config.misc")
      require("plugins.config.notify")
      require("plugins.config.session")
      require("plugins.config.splitjoin")
      require("plugins.config.starter")
      require("plugins.config.statusline")

      require('mini.ai').setup()
      require('mini.align').setup()
      require('mini.bracketed').setup()
      require('mini.git').setup()
      require('mini.move').setup()
      require('mini.pairs').setup()
      require('mini.surround').setup()
      require('mini.tabline').setup()
      require('mini.visits').setup()
   end }
