local M = {}

function M.setup()
	require('base16-colorscheme').setup {
		-- Background tones
		base00 = '#1a231f', -- Default Background
		base01 = '#2c3a34', -- Lighter Background (status bars)
		base02 = '#28342f', -- Selection Background
		base03 = '#5b6f67', -- Comments, Invisibles
		-- Foreground tones
		base04 = '#afb6b3', -- Dark Foreground (status bars)
		base05 = '#f2f3f2', -- Default Foreground
		base06 = '#f2f3f2', -- Light Foreground
		base07 = '#f2f3f2', -- Lightest Foreground
		-- Accent colors
		base08 = '#fd4663', -- Variables, XML Tags, Errors
		base09 = '#6690cc', -- Integers, Constants
		base0A = '#5ccfd6', -- Classes, Search Background
		base0B = '#67e4b1', -- Strings, Diff Inserted
		base0C = '#96b8e9', -- Regex, Escape Chars
		base0D = '#93ecc7', -- Functions, Methods
		base0E = '#96e4e9', -- Keywords, Storage
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
