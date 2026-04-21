local config = {
   view = {
      style = "sign",
      signs = {
         add    = '+',
         change = '~',
         delete = '-',
         -- add    = '▌',
         -- change = '▌',
         -- delete = '▌',
      }
   }
}

require('mini.diff').setup(config)
