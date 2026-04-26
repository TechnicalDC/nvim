local M = {}

function M.setup()
	require('base16-colorscheme').setup {
		-- Background tones
		base00 = '#1e2127', -- Default Background
		base01 = '#282c34', -- Lighter Background (status bars)
		base02 = '#313640', -- Selection Background
		base03 = '#616b7f', -- Comments, Invisibles
		-- Foreground tones
		base04 = '#61afef', -- Dark Foreground (status bars)
		base05 = '#cdd4e1', -- Default Foreground
		base06 = '#cdd4e1', -- Light Foreground
		base07 = '#cdd4e1', -- Lightest Foreground
		-- Accent colors
		base08 = '#e06c75', -- Variables, XML Tags, Errors
		base09 = '#98c379', -- Integers, Constants
		base0A = '#c678dd', -- Classes, Search Background
		base0B = '#61afef', -- Strings, Diff Inserted
		base0C = '#b9e996', -- Regex, Escape Chars
		base0D = '#8bc4f3', -- Functions, Methods
		base0E = '#d696e9', -- Keywords, Storage
		base0F = '#e06c75', -- Deprecated, Embedded Tags
	}
end

-- Register a signal handler for SIGUSR1 (matugen updates)
local signal = vim.uv.new_signal()
signal:start(
	'sigusr1',
	vim.schedule_wrap(function()
		package.loaded['matugen'] = nil
		require('matugen').setup()
	end)
)

return M
