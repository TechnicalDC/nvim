 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#121318',
    base01 = '#1e1f25',
    base02 = '#272830',
    base03 = '#5f616a',
    base04 = '#c5c6d0',
    base05 = '#e3e2e9',
    base06 = '#e3e2e9',
    base07 = '#e3e2e9',
    base08 = '#ffb4ab',
    base09 = '#e1bbdc',
    base0A = '#c0c6dd',
    base0B = '#b2c5ff',
    base0C = '#e996de',
    base0D = '#809fff',
    base0E = '#96a7e9',
    base0F = '#bec9f4',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#e3e2e9',          bg = '#121318' })
  hi('TelescopeBorder',         { fg = '#5f616a',             bg = '#121318' })
  hi('TelescopePromptNormal',   { fg = '#e3e2e9',          bg = '#121318' })
  hi('TelescopePromptBorder',   { fg = '#5f616a',             bg = '#121318' })
  hi('TelescopePromptPrefix',   { fg = '#b2c5ff',             bg = '#121318' })
  hi('TelescopePromptCounter',  { fg = '#c5c6d0',  bg = '#121318' })
  hi('TelescopePromptTitle',    { fg = '#121318',             bg = '#b2c5ff' })
  hi('TelescopePreviewTitle',   { fg = '#121318',             bg = '#c0c6dd' })
  hi('TelescopeResultsTitle',   { fg = '#121318',             bg = '#e1bbdc' })
  hi('TelescopeSelection',      { fg = '#e3e2e9',          bg = '#272830' })
  hi('TelescopeSelectionCaret', { fg = '#b2c5ff',             bg = '#272830' })
  hi('TelescopeMatching',       { fg = '#b2c5ff',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#e3e2e9',          bg = '#121318' })
  hi('MiniPickBorder',         { fg = '#5f616a',             bg = '#121318' })
  hi('MiniPickPrompt',   { fg = '#e3e2e9',          bg = '#121318' })
  hi('MiniPickPromptPrefix',   { fg = '#b2c5ff',             bg = '#121318' })
  hi('MiniPickBorderText',    { fg = '#121318',             bg = '#b2c5ff' })
  hi('MiniPickMatchCurrent',      { fg = '#e3e2e9',          bg = '#272830' })
  hi('MiniPickPromptCaret', { fg = '#b2c5ff',             bg = '#272830' })
  hi('MiniPickMatchRanges',       { fg = '#b2c5ff',             bold = true })
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
