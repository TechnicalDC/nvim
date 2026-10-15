 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#0f1511',
    base01 = '#1c211c',
    base02 = '#262b27',
    base03 = '#8b938a',
    base04 = '#c0c9bf',
    base05 = '#dfe4dd',
    base06 = '#dfe4dd',
    base07 = '#dfe4dd',
    base08 = '#ffb4ab',
    base09 = '#a3cdda',
    base0A = '#b6ccb9',
    base0B = '#95d5a8',
    base0C = '#a3cdda',
    base0D = '#95d5a8',
    base0E = '#b6ccb9',
    base0F = '#d1e8d4',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#dfe4dd',          bg = '#0f1511' })
  hi('TelescopeBorder',         { fg = '#8b938a',             bg = '#0f1511' })
  hi('TelescopePromptNormal',   { fg = '#dfe4dd',          bg = '#0f1511' })
  hi('TelescopePromptBorder',   { fg = '#8b938a',             bg = '#0f1511' })
  hi('TelescopePromptPrefix',   { fg = '#95d5a8',             bg = '#0f1511' })
  hi('TelescopePromptCounter',  { fg = '#c0c9bf',  bg = '#0f1511' })
  hi('TelescopePromptTitle',    { fg = '#0f1511',             bg = '#95d5a8' })
  hi('TelescopePreviewTitle',   { fg = '#0f1511',             bg = '#b6ccb9' })
  hi('TelescopeResultsTitle',   { fg = '#0f1511',             bg = '#a3cdda' })
  hi('TelescopeSelection',      { fg = '#dfe4dd',          bg = '#262b27' })
  hi('TelescopeSelectionCaret', { fg = '#95d5a8',             bg = '#262b27' })
  hi('TelescopeMatching',       { fg = '#95d5a8',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#dfe4dd',          bg = '#0f1511' })
  hi('MiniPickBorder',         { fg = '#8b938a',             bg = '#0f1511' })
  hi('MiniPickPrompt',   { fg = '#dfe4dd',          bg = '#0f1511' })
  hi('MiniPickPromptPrefix',   { fg = '#95d5a8',             bg = '#0f1511' })
  hi('MiniPickBorderText',    { fg = '#0f1511',             bg = '#95d5a8' })
  hi('MiniPickMatchCurrent',      { fg = '#dfe4dd',          bg = '#262b27' })
  hi('MiniPickPromptCaret', { fg = '#95d5a8',             bg = '#262b27' })
  hi('MiniPickMatchRanges',       { fg = '#95d5a8',             bold = true })
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
