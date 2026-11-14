 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#32302f',
    base01 = '#3c3836',
    base02 = '#474240',
    base03 = '#7f7873',
    base04 = '#d4be98',
    base05 = '#ddc7a1',
    base06 = '#ddc7a1',
    base07 = '#ddc7a1',
    base08 = '#ea6962',
    base09 = '#89b482',
    base0A = '#e78a4e',
    base0B = '#a9b665',
    base0C = '#a1e996',
    base0D = '#dbe996',
    base0E = '#f0b58f',
    base0F = '#f6d2bc',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#ddc7a1',          bg = '#32302f' })
  hi('TelescopeBorder',         { fg = '#7f7873',             bg = '#32302f' })
  hi('TelescopePromptNormal',   { fg = '#ddc7a1',          bg = '#32302f' })
  hi('TelescopePromptBorder',   { fg = '#7f7873',             bg = '#32302f' })
  hi('TelescopePromptPrefix',   { fg = '#a9b665',             bg = '#32302f' })
  hi('TelescopePromptCounter',  { fg = '#d4be98',  bg = '#32302f' })
  hi('TelescopePromptTitle',    { fg = '#32302f',             bg = '#a9b665' })
  hi('TelescopePreviewTitle',   { fg = '#32302f',             bg = '#e78a4e' })
  hi('TelescopeResultsTitle',   { fg = '#32302f',             bg = '#89b482' })
  hi('TelescopeSelection',      { fg = '#ddc7a1',          bg = '#474240' })
  hi('TelescopeSelectionCaret', { fg = '#a9b665',             bg = '#474240' })
  hi('TelescopeMatching',       { fg = '#a9b665',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#ddc7a1',          bg = '#32302f' })
  hi('MiniPickBorder',         { fg = '#7f7873',             bg = '#32302f' })
  hi('MiniPickPrompt',   { fg = '#ddc7a1',          bg = '#32302f' })
  hi('MiniPickPromptPrefix',   { fg = '#a9b665',             bg = '#32302f' })
  hi('MiniPickBorderText',    { fg = '#32302f',             bg = '#a9b665' })
  hi('MiniPickMatchCurrent',      { fg = '#ddc7a1',          bg = '#474240' })
  hi('MiniPickPromptCaret', { fg = '#a9b665',             bg = '#474240' })
  hi('MiniPickMatchRanges',       { fg = '#a9b665',             bold = true })
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
