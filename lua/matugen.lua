 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#101417',
    base01 = '#1c2024',
    base02 = '#262a2e',
    base03 = '#8b9198',
    base04 = '#c1c7ce',
    base05 = '#e0e3e8',
    base06 = '#e0e3e8',
    base07 = '#e0e3e8',
    base08 = '#ffb4ab',
    base09 = '#cec0e8',
    base0A = '#b7c9d9',
    base0B = '#95cdf7',
    base0C = '#cec0e8',
    base0D = '#95cdf7',
    base0E = '#b7c9d9',
    base0F = '#d3e5f5',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#e0e3e8',          bg = '#101417' })
  hi('TelescopeBorder',         { fg = '#8b9198',             bg = '#101417' })
  hi('TelescopePromptNormal',   { fg = '#e0e3e8',          bg = '#101417' })
  hi('TelescopePromptBorder',   { fg = '#8b9198',             bg = '#101417' })
  hi('TelescopePromptPrefix',   { fg = '#95cdf7',             bg = '#101417' })
  hi('TelescopePromptCounter',  { fg = '#c1c7ce',  bg = '#101417' })
  hi('TelescopePromptTitle',    { fg = '#101417',             bg = '#95cdf7' })
  hi('TelescopePreviewTitle',   { fg = '#101417',             bg = '#b7c9d9' })
  hi('TelescopeResultsTitle',   { fg = '#101417',             bg = '#cec0e8' })
  hi('TelescopeSelection',      { fg = '#e0e3e8',          bg = '#262a2e' })
  hi('TelescopeSelectionCaret', { fg = '#95cdf7',             bg = '#262a2e' })
  hi('TelescopeMatching',       { fg = '#95cdf7',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#e0e3e8',          bg = '#101417' })
  hi('MiniPickBorder',         { fg = '#8b9198',             bg = '#101417' })
  hi('MiniPickPrompt',   { fg = '#e0e3e8',          bg = '#101417' })
  hi('MiniPickPromptPrefix',   { fg = '#95cdf7',             bg = '#101417' })
  hi('MiniPickBorderText',    { fg = '#101417',             bg = '#95cdf7' })
  hi('MiniPickMatchCurrent',      { fg = '#e0e3e8',          bg = '#262a2e' })
  hi('MiniPickPromptCaret', { fg = '#95cdf7',             bg = '#262a2e' })
  hi('MiniPickMatchRanges',       { fg = '#95cdf7',             bold = true })
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
