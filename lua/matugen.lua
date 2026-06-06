local M = {}

function M.setup()
	require('base16-colorscheme').setup {
		-- Background tones
		base00 = '#1e112c', -- Default Background
		base01 = '#321d49', -- Lighter Background (status bars)
		base02 = '#2d1a42', -- Selection Background
		base03 = '#696074', -- Comments, Invisibles
		-- Foreground tones
		base04 = '#b2afb6', -- Dark Foreground (status bars)
		base05 = '#f2f2f3', -- Default Foreground
		base06 = '#f2f2f3', -- Light Foreground
		base07 = '#f2f2f3', -- Lightest Foreground
		-- Accent colors
		base08 = '#fd4663', -- Variables, XML Tags, Errors
		base09 = '#cc669c', -- Integers, Constants
		base0A = '#d25cd6', -- Classes, Search Background
		base0B = '#a167e4', -- Strings, Diff Inserted
		base0C = '#e996c2', -- Regex, Escape Chars
		base0D = '#bc93ec', -- Functions, Methods
		base0E = '#e696e9', -- Keywords, Storage
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
