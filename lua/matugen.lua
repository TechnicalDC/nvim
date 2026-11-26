 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#000000',
    base01 = '#171717',
    base02 = '#212121',
    base03 = '#636363',
    base04 = '#dde1e6',
    base05 = '#f2f4f8',
    base06 = '#f2f4f8',
    base07 = '#f2f4f8',
    base08 = '#ee5396',
    base09 = '#be95ff',
    base0A = '#42be65',
    base0B = '#33b1ff',
    base0C = '#b180ff',
    base0D = '#80ceff',
    base0E = '#96e9ad',
    base0F = '#bef4cd',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#f2f4f8',          bg = '#000000' })
  hi('TelescopeBorder',         { fg = '#636363',             bg = '#000000' })
  hi('TelescopePromptNormal',   { fg = '#f2f4f8',          bg = '#000000' })
  hi('TelescopePromptBorder',   { fg = '#636363',             bg = '#000000' })
  hi('TelescopePromptPrefix',   { fg = '#33b1ff',             bg = '#000000' })
  hi('TelescopePromptCounter',  { fg = '#dde1e6',  bg = '#000000' })
  hi('TelescopePromptTitle',    { fg = '#000000',             bg = '#33b1ff' })
  hi('TelescopePreviewTitle',   { fg = '#000000',             bg = '#42be65' })
  hi('TelescopeResultsTitle',   { fg = '#000000',             bg = '#be95ff' })
  hi('TelescopeSelection',      { fg = '#f2f4f8',          bg = '#212121' })
  hi('TelescopeSelectionCaret', { fg = '#33b1ff',             bg = '#212121' })
  hi('TelescopeMatching',       { fg = '#33b1ff',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#f2f4f8',          bg = '#000000' })
  hi('MiniPickBorder',         { fg = '#636363',             bg = '#000000' })
  hi('MiniPickPrompt',   { fg = '#f2f4f8',          bg = '#000000' })
  hi('MiniPickPromptPrefix',   { fg = '#33b1ff',             bg = '#000000' })
  hi('MiniPickBorderText',    { fg = '#000000',             bg = '#33b1ff' })
  hi('MiniPickMatchCurrent',      { fg = '#f2f4f8',          bg = '#212121' })
  hi('MiniPickPromptCaret', { fg = '#33b1ff',             bg = '#212121' })
  hi('MiniPickMatchRanges',       { fg = '#33b1ff',             bold = true })
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
