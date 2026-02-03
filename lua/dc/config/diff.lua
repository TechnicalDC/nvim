local config = {
   view = {
      style = "sign",
      signs = {
         add    = '▌',
         change = '▌',
         delete = '▌',
      }
   }
}

require('mini.diff').setup(config)
