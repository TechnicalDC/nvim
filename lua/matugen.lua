 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#000000',
    base01 = '#0a1022',
    base02 = '#12192f',
    base03 = '#646d8e',
    base04 = '#abb4da',
    base05 = '#ebfafa',
    base06 = '#ebfafa',
    base07 = '#ebfafa',
    base08 = '#f16c75',
    base09 = '#a48cf2',
    base0A = '#04d1f9',
    base0B = '#37f499',
    base0C = '#a48cf2',
    base0D = '#86f8c1',
    base0E = '#82e9fd',
    base0F = '#b4f2fe',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#ebfafa',          bg = '#000000' })
  hi('TelescopeBorder',         { fg = '#646d8e',             bg = '#000000' })
  hi('TelescopePromptNormal',   { fg = '#ebfafa',          bg = '#000000' })
  hi('TelescopePromptBorder',   { fg = '#646d8e',             bg = '#000000' })
  hi('TelescopePromptPrefix',   { fg = '#37f499',             bg = '#000000' })
  hi('TelescopePromptCounter',  { fg = '#abb4da',  bg = '#000000' })
  hi('TelescopePromptTitle',    { fg = '#000000',             bg = '#37f499' })
  hi('TelescopePreviewTitle',   { fg = '#000000',             bg = '#04d1f9' })
  hi('TelescopeResultsTitle',   { fg = '#000000',             bg = '#a48cf2' })
  hi('TelescopeSelection',      { fg = '#ebfafa',          bg = '#12192f' })
  hi('TelescopeSelectionCaret', { fg = '#37f499',             bg = '#12192f' })
  hi('TelescopeMatching',       { fg = '#37f499',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#ebfafa',          bg = '#000000' })
  hi('MiniPickBorder',         { fg = '#646d8e',             bg = '#000000' })
  hi('MiniPickPrompt',   { fg = '#ebfafa',          bg = '#000000' })
  hi('MiniPickPromptPrefix',   { fg = '#37f499',             bg = '#000000' })
  hi('MiniPickBorderText',    { fg = '#000000',             bg = '#37f499' })
  hi('MiniPickMatchCurrent',      { fg = '#ebfafa',          bg = '#12192f' })
  hi('MiniPickPromptCaret', { fg = '#37f499',             bg = '#12192f' })
  hi('MiniPickMatchRanges',       { fg = '#37f499',             bold = true })
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
