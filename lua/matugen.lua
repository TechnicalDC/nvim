local M = {}

function M.setup()
	require('base16-colorscheme').setup {
		-- Background tones
		base00 = '#1c1e21', -- Default Background
		base01 = '#2f3237', -- Lighter Background (status bars)
		base02 = '#2a2d32', -- Selection Background
		base03 = '#66686f', -- Comments, Invisibles
		-- Foreground tones
		base04 = '#b0b2b5', -- Dark Foreground (status bars)
		base05 = '#f2f2f3', -- Default Foreground
		base06 = '#f2f2f3', -- Light Foreground
		base07 = '#f2f2f3', -- Lightest Foreground
		-- Accent colors
		base08 = '#fd4663', -- Variables, XML Tags, Errors
		base09 = '#9391a1', -- Integers, Constants
		base0A = '#9192a1', -- Classes, Search Background
		base0B = '#9ea3ad', -- Strings, Diff Inserted
		base0C = '#bcbac4', -- Regex, Escape Chars
		base0D = '#babdc5', -- Functions, Methods
		base0E = '#babbc4', -- Keywords, Storage
		base0F = '#fd4663', -- Deprecated, Embedded Tags
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
