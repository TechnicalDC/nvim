return {
   'L3MON4D3/LuaSnip',
   event = { "BufReadPre", "BufNewFile" },
   config = function ()
      local ls = require("luasnip")
      local types = require("luasnip.util.types")
		local map = vim.keymap.set

      if vim.fn.has("win32") == 1 then
         -- For windows
         require("luasnip.loaders.from_lua").load({ paths = "~/Appdata/Local/nvim/snippets/" })
      else
         -- For linux
         require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
      end

      ls.config.set_config({
         store_selection_keys = '<C-s>',
         history = true, -- keep around last snippet local to jump back
         updateevents = "TextChanged,TextChangedI", -- update changes as you type
         enable_autosnippets = true,
         ext_opts = {
            [types.choiceNode] = {
               active = {
                  virt_text = { { "󰍡 Choice Node ", "OrangeSign" } },
               },
            },
         },
      })

      map({ "i", "s" },   "<C-j>", function() ls.jump(1) end,           { desc = "Jump to next node" } )
      map({ "i", "s" },   "<C-k>", function() ls.jump(-1) end,          { desc = "Jump to previous node" } )
      map({ "i", "s" },   "<C-n>", function() ls.change_choice(1)  end, { desc = "Select next choice" } )
      map({ "i", "s" },   "<C-p>", function() ls.change_choice(-1) end, { desc = "Select previous choice" } )
   end
}
