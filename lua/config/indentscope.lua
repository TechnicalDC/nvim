require('mini.indentscope').setup({
   options = {
      try_as_border = true,
      border = 'both',
   }
})

-- Disable only for certain filetypes (for example, "lua" and "help")
vim.api.nvim_create_autocmd('Filetype', {
   pattern = {
      "markdown",
      "lazy",
      "mason",
      "help",
      "ministarter"
   },
   callback = function(args)
      vim.b[args.buf].miniindentscope_disable = true
   end
})
