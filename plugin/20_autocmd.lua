local autocmd = vim.api.nvim_create_autocmd

-- Highlight when yanking (copying) text
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Open help in vertical split
autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})
