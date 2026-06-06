local input = require('mini.input')

-- Use border different from 'winborder'
local adjust_config = function(_, config)
	config.border = "rounded"
	config.width = 50
	config.col = math.floor(( vim.o.columns - config.width ) * 0.5)
	return config
end

-- Choose initial style based on the scope
local floatwin = input.gen_view.floatwin
local view_tm = floatwin({ style = 'MM', adjust_config = adjust_config })
local view_bl = floatwin({ style = 'BL', adjust_config = adjust_config })
local view_handler = function(state)
	local scope, view = state.opts.scope, view_tm
	if scope == 'cursor' or scope == 'line' then view = view_bl end
	return view(state)
end

input.setup({ handlers = { view = view_handler } })
-- Construct reusable `input.get()` options
local cmdline_opts = { prompt = 'Command', scope = 'editor' }
-- - Highlight using bundled Vim tree-sitter parser and default handler
local highlight_vim = input.gen_highlight.treesitter('vim')
local highlight_cmdline = function(state)
  state = highlight_vim(state) or state
  return input.default_highlight(state) or state
end
cmdline_opts.handlers = { highlight = highlight_cmdline }
-- - Complete as if it is Command line input
cmdline_opts.completion = 'cmdline'

-- Create a mapping for `:`
local input_cmdline = function()
	local cmd = input.get(cmdline_opts)
	if cmd ~= nil then vim.cmd(cmd) end
end
vim.keymap.set('n', ':', input_cmdline)
