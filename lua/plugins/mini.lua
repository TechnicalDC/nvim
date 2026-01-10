return {
   'nvim-mini/mini.nvim',
   version = false,
   config = function()
      require("config.pick")
      require("config.clue")
      require("config.diff")
      require("config.files")
      require("config.hipatterns")
      require("config.icons")
      require("config.indentscope")
      require("config.misc")
      require("config.notify")
      require("config.session")
      require("config.splitjoin")
      require("config.starter")
      require("config.statusline")

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
