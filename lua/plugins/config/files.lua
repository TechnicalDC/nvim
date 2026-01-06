local autocmd = vim.api.nvim_create_autocmd

-- FUNCTIONS {{{
local nmap = function(lhs, rhs, desc)
  -- See `:h vim.keymap.set()`
  vim.keymap.set('n', lhs, rhs, { desc = desc })
end

local filter_hide = function(fs_entry)
   return not vim.startswith(fs_entry.name, '.')
end

local toggle_dotfiles = function()
   show_dotfiles = not show_dotfiles
   local new_filter = show_dotfiles and true or filter_hide
   miniFiles.refresh({ content = { filter = new_filter } })
end
-- }}}

local config = {
   options = { use_as_default_explorer = false, },
   -- Module mappings created only inside explorer.
   -- Use `''` (empty string) to not create one.
   mappings = {
      close       = 'q',
      go_in       = 'l',
      go_in_plus  = '<CR>',
      go_out      = 'h',
      go_out_plus = 'H',
      mark_goto   = "'",
      mark_set    = 'm',
      reset       = '<BS>',
      reveal_cwd  = '@',
      show_help   = 'g?',
      synchronize = 's',
      trim_left   = '<',
      trim_right  = '>',
   },
   windows = {
      -- Maximum number of windows to show side by side
      max_number = 3,
      -- Whether to show preview of file/directory under cursor
      preview = true,
      -- Width of focused window
      width_focus = 50,
      -- Width of non-focused window
      width_nofocus = 30,
      -- Width of preview window
      width_preview = 50,
   },
}

require('mini.files').setup(config)

autocmd('User', {
   pattern = 'MiniFilesBufferCreate',
   callback = function(args)
      local buf_id = args.data.buf_id
      -- Tweak left-hand side of mapping to your liking
      vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
   end
})

autocmd('User', {
   pattern = 'MiniFilesWindowUpdate',
   callback = function(args)
      local config = vim.api.nvim_win_get_config(args.data.win_id)

      vim.wo[args.data.win_id].number = true
      vim.wo[args.data.win_id].relativenumber = true
      vim.wo[args.data.win_id].statuscolumn = "%s%=%{v:relnum ? v:relnum : v:lnum} "

      vim.api.nvim_win_set_config(args.data.win_id, config)
   end,
})

nmap( "<leader>of", function() require("mini.files").open(vim.uv.cwd(), true) end, "Open mini.files (cwd)" )
nmap( "<leader>oF", function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end, "Open mini.files (Directory of Current File)" )
