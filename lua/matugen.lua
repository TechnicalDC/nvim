 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#17130b',
    base01 = '#241f17',
    base02 = '#302a1f',
    base03 = '#6a6053',
    base04 = '#d2c5b4',
    base05 = '#ece1d4',
    base06 = '#ece1d4',
    base07 = '#ece1d4',
    base08 = '#ffb4ab',
    base09 = '#b5cea4',
    base0A = '#dbc3a1',
    base0B = '#f0bf6d',
    base0C = '#b7e996',
    base0D = '#f3cc8b',
    base0E = '#e9c696',
    base0F = '#f4ddbe',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#ece1d4',          bg = '#17130b' })
  hi('TelescopeBorder',         { fg = '#6a6053',             bg = '#17130b' })
  hi('TelescopePromptNormal',   { fg = '#ece1d4',          bg = '#17130b' })
  hi('TelescopePromptBorder',   { fg = '#6a6053',             bg = '#17130b' })
  hi('TelescopePromptPrefix',   { fg = '#f0bf6d',             bg = '#17130b' })
  hi('TelescopePromptCounter',  { fg = '#d2c5b4',  bg = '#17130b' })
  hi('TelescopePromptTitle',    { fg = '#17130b',             bg = '#f0bf6d' })
  hi('TelescopePreviewTitle',   { fg = '#17130b',             bg = '#dbc3a1' })
  hi('TelescopeResultsTitle',   { fg = '#17130b',             bg = '#b5cea4' })
  hi('TelescopeSelection',      { fg = '#ece1d4',          bg = '#302a1f' })
  hi('TelescopeSelectionCaret', { fg = '#f0bf6d',             bg = '#302a1f' })
  hi('TelescopeMatching',       { fg = '#f0bf6d',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#ece1d4',          bg = '#17130b' })
  hi('MiniPickBorder',         { fg = '#6a6053',             bg = '#17130b' })
  hi('MiniPickPrompt',   { fg = '#ece1d4',          bg = '#17130b' })
  hi('MiniPickPromptPrefix',   { fg = '#f0bf6d',             bg = '#17130b' })
  hi('MiniPickBorderText',    { fg = '#17130b',             bg = '#f0bf6d' })
  hi('MiniPickMatchCurrent',      { fg = '#ece1d4',          bg = '#302a1f' })
  hi('MiniPickPromptCaret', { fg = '#f0bf6d',             bg = '#302a1f' })
  hi('MiniPickMatchRanges',       { fg = '#f0bf6d',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
