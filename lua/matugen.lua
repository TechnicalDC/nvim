 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#000000',
    base01 = '#1a0f16',
    base02 = '#271621',
    base03 = '#6e5160',
    base04 = '#ff8cb3',
    base05 = '#ffe0eb',
    base06 = '#ffe0eb',
    base07 = '#ffe0eb',
    base08 = '#ff99b8',
    base09 = '#ffcce0',
    base0A = '#ffb3cc',
    base0B = '#ff8cb3',
    base0C = '#ff80b1',
    base0D = '#ff80ab',
    base0E = '#ff80a9',
    base0F = '#ffb3cc',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#ffe0eb',          bg = '#000000' })
  hi('TelescopeBorder',         { fg = '#6e5160',             bg = '#000000' })
  hi('TelescopePromptNormal',   { fg = '#ffe0eb',          bg = '#000000' })
  hi('TelescopePromptBorder',   { fg = '#6e5160',             bg = '#000000' })
  hi('TelescopePromptPrefix',   { fg = '#ff8cb3',             bg = '#000000' })
  hi('TelescopePromptCounter',  { fg = '#ff8cb3',  bg = '#000000' })
  hi('TelescopePromptTitle',    { fg = '#000000',             bg = '#ff8cb3' })
  hi('TelescopePreviewTitle',   { fg = '#000000',             bg = '#ffb3cc' })
  hi('TelescopeResultsTitle',   { fg = '#000000',             bg = '#ffcce0' })
  hi('TelescopeSelection',      { fg = '#ffe0eb',          bg = '#271621' })
  hi('TelescopeSelectionCaret', { fg = '#ff8cb3',             bg = '#271621' })
  hi('TelescopeMatching',       { fg = '#ff8cb3',             bold = true })
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
