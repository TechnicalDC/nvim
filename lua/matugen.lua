 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1b0538',
    base01 = '#2e0f57',
    base02 = '#290b50',
    base03 = '#655e6e',
    base04 = '#b2afb6',
    base05 = '#f2f2f3',
    base06 = '#f2f2f3',
    base07 = '#f2f2f3',
    base08 = '#fd4663',
    base09 = '#ef43a6',
    base0A = '#e243ef',
    base0B = '#9b5af1',
    base0C = '#f589c7',
    base0D = '#b889f5',
    base0E = '#ed89f5',
    base0F = '#f4b9f9',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#f2f2f3',          bg = '#1b0538' })
  hi('TelescopeBorder',         { fg = '#655e6e',             bg = '#1b0538' })
  hi('TelescopePromptNormal',   { fg = '#f2f2f3',          bg = '#1b0538' })
  hi('TelescopePromptBorder',   { fg = '#655e6e',             bg = '#1b0538' })
  hi('TelescopePromptPrefix',   { fg = '#9b5af1',             bg = '#1b0538' })
  hi('TelescopePromptCounter',  { fg = '#b2afb6',  bg = '#1b0538' })
  hi('TelescopePromptTitle',    { fg = '#1b0538',             bg = '#9b5af1' })
  hi('TelescopePreviewTitle',   { fg = '#1b0538',             bg = '#e243ef' })
  hi('TelescopeResultsTitle',   { fg = '#1b0538',             bg = '#ef43a6' })
  hi('TelescopeSelection',      { fg = '#f2f2f3',          bg = '#290b50' })
  hi('TelescopeSelectionCaret', { fg = '#9b5af1',             bg = '#290b50' })
  hi('TelescopeMatching',       { fg = '#9b5af1',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#f2f2f3',          bg = '#1b0538' })
  hi('MiniPickBorder',         { fg = '#655e6e',             bg = '#1b0538' })
  hi('MiniPickPrompt',   { fg = '#f2f2f3',          bg = '#1b0538' })
  hi('MiniPickPromptPrefix',   { fg = '#9b5af1',             bg = '#1b0538' })
  hi('MiniPickBorderText',    { fg = '#1b0538',             bg = '#9b5af1' })
  hi('MiniPickMatchCurrent',      { fg = '#f2f2f3',          bg = '#290b50' })
  hi('MiniPickPromptCaret', { fg = '#9b5af1',             bg = '#290b50' })
  hi('MiniPickMatchRanges',       { fg = '#9b5af1',             bold = true })
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
