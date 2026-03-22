local M = {}

function M.setup()
	require('base16-colorscheme').setup {
		-- Background tones
		base00 = '#1c2021', -- Default Background
		base01 = '#2f3537', -- Lighter Background (status bars)
		base02 = '#2a2f32', -- Selection Background
		base03 = '#646b6d', -- Comments, Invisibles
		-- Foreground tones
		base04 = '#b0b4b5', -- Dark Foreground (status bars)
		base05 = '#f2f2f3', -- Default Foreground
		base06 = '#f2f2f3', -- Light Foreground
		base07 = '#f2f2f3', -- Lightest Foreground
		-- Accent colors
		base08 = '#fd4663', -- Variables, XML Tags, Errors
		base09 = '#8f94a3', -- Integers, Constants
		base0A = '#8d99a5', -- Classes, Search Background
		base0B = '#98acb3', -- Strings, Diff Inserted
		base0C = '#b9bcc5', -- Regex, Escape Chars
		base0D = '#b6c4c9', -- Functions, Methods
		base0E = '#b8bfc7', -- Keywords, Storage
		base0F = '#533d41', -- Deprecated, Embedded Tags
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
