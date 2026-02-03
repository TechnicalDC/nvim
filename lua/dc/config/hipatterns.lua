local hipatterns    = require('mini.hipatterns')
local map = function(lhs, rhs, desc)
   vim.keymap.set("n", lhs, rhs, { desc = desc })
end
local todo_patterns = {
   todo = " TODO ",
   prog = " PROG ",
   wait = " WAIT ",
   done = " DONE "
}
local toggle_todo = function (newStatus)
   local str = vim.api.nvim_get_current_line()

   if string.match(str, todo_patterns.todo) then
      vim.cmd("s/" .. todo_patterns.todo .. "/" .. newStatus .. "/")
   end

   if string.match(str, todo_patterns.wait)  then
      vim.cmd("s/" .. todo_patterns.wait .. "/" .. newStatus .. "/")
   end

   if string.match(str, todo_patterns.prog)  then
      vim.cmd("s/" .. todo_patterns.prog .. "/" .. newStatus .. "/")
   end

   if string.match(str, todo_patterns.done)  then
      vim.cmd("s/" .. todo_patterns.done .. "/" .. newStatus .. "/")
   end
end

hipatterns.setup({
   highlighters = {
      fixme = { pattern = 'FIXME:', group = 'MiniHipatternsFixme' },
      todo  = { pattern = 'TODO:',  group = 'MiniHipatternsTodo'  },
      note  = { pattern = 'NOTE:',  group = 'MiniHipatternsNote'  },
      debug = { pattern = 'DEBUG:', group = 'MiniHipatternsDebug'  },

      done     = { pattern = todo_patterns.done, group = 'MiniHipatternsDone'  },
      prog     = { pattern = todo_patterns.prog, group = 'MiniHipatternsProgress'  },
      wait     = { pattern = todo_patterns.wait, group = 'MiniHipatternsPending'  },
      todo1    = { pattern = todo_patterns.todo, group = 'MiniHipatternsTodo'  },

      hex_color = hipatterns.gen_highlighter.hex_color(),
   }
})

map("<leader>td", function ()
   toggle_todo(todo_patterns.done)
end, "Change to 'DONE'")

map("<leader>tt", function ()
   toggle_todo(todo_patterns.todo)
end, "Change to 'TODO'")

map("<leader>tp", function ()
   toggle_todo(todo_patterns.prog)
end, "Change to 'PROG'")

map("<leader>tw", function ()
   toggle_todo(todo_patterns.wait)
end, "Change to 'WAIT'")
