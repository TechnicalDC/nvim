 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#120f2e',
    base01 = '#1e194d',
    base02 = '#1b1745',
    base03 = '#61606f',
    base04 = '#afafb6',
    base05 = '#f2f2f3',
    base06 = '#f2f2f3',
    base07 = '#f2f2f3',
    base08 = '#fd4663',
    base09 = '#cd65c3',
    base0A = '#a35cd6',
    base0B = '#7367e4',
    base0C = '#e996e1',
    base0D = '#9b93ec',
    base0E = '#c696e9',
    base0F = '#ddbef4',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#f2f2f3',          bg = '#120f2e' })
  hi('TelescopeBorder',         { fg = '#61606f',             bg = '#120f2e' })
  hi('TelescopePromptNormal',   { fg = '#f2f2f3',          bg = '#120f2e' })
  hi('TelescopePromptBorder',   { fg = '#61606f',             bg = '#120f2e' })
  hi('TelescopePromptPrefix',   { fg = '#7367e4',             bg = '#120f2e' })
  hi('TelescopePromptCounter',  { fg = '#afafb6',  bg = '#120f2e' })
  hi('TelescopePromptTitle',    { fg = '#120f2e',             bg = '#7367e4' })
  hi('TelescopePreviewTitle',   { fg = '#120f2e',             bg = '#a35cd6' })
  hi('TelescopeResultsTitle',   { fg = '#120f2e',             bg = '#cd65c3' })
  hi('TelescopeSelection',      { fg = '#f2f2f3',          bg = '#1b1745' })
  hi('TelescopeSelectionCaret', { fg = '#7367e4',             bg = '#1b1745' })
  hi('TelescopeMatching',       { fg = '#7367e4',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#f2f2f3',          bg = '#120f2e' })
  hi('MiniPickBorder',         { fg = '#61606f',             bg = '#120f2e' })
  hi('MiniPickPrompt',   { fg = '#f2f2f3',          bg = '#120f2e' })
  hi('MiniPickPromptPrefix',   { fg = '#7367e4',             bg = '#120f2e' })
  hi('MiniPickBorderText',    { fg = '#120f2e',             bg = '#7367e4' })
  hi('MiniPickMatchCurrent',      { fg = '#f2f2f3',          bg = '#1b1745' })
  hi('MiniPickPromptCaret', { fg = '#7367e4',             bg = '#1b1745' })
  hi('MiniPickMatchRanges',       { fg = '#7367e4',             bold = true })
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
