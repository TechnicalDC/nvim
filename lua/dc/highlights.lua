local hl = vim.api.nvim_set_hl
local colors = require('base16-colorscheme').colors
local M = {}

function M.solid()

	-- Built-in
	hl(0, "NormalFloat",                        { bg = colors.base02 })
	hl(0, "FloatBorder",                        { fg = colors.base02, bg = colors.base02 })
	hl(0, "SignColumn",                         { link = "Normal" })
	hl(0, "FloatTitle",                         { fg = colors.base00, bg = colors.base08 })
	hl(0, "WinSeparator",                       { fg = colors.base02 })
	hl(0, "StatusLineMode",                     { fg = colors.base00, bg = colors.base08, bold = true })
	hl(0, "Winbar",                             { link = "StatusLine"})
	hl(0, "WinbarNC",                           { link = "StatusLine"})
	hl(0, "TabLineFill",                        { link = "StatusLine" })
	hl(0, "TabLineSel",                         { link = "StatusLineMode" })
	hl(0, "LineNr",                             { fg = colors.base03 })
	hl(0, "FoldColumn",                         { link = "LineNr" })
	hl(0, "Folded",                             { link = "LineNr" })
	hl(0, "CursorLineNr",                       { bg = "none", bold = true })
	hl(0, "DiagnosticUnderlineError",           { undercurl = true })
	hl(0, "DiagnosticUnderlineHint",            { undercurl = true })
	hl(0, "DiagnosticUnderlineInfo",            { undercurl = true })
	hl(0, "DiagnosticUnderlineOk",              { undercurl = true })
	hl(0, "DiagnosticUnderlineWarn",            { undercurl = true })
	hl(0, "ErrorMsg",                           { link = "Error" })
	hl(0, "Comment",                            { fg = colors.base03, italic = true })
	hl(0, "@markup.link.label.markdown_inline", { fg = colors.base0E, underline = true })
	hl(0, "Pmenu",                              { fg = colors.base05 })
	hl(0, "PmenuSel",                           { bg = colors.base01 })

	-- Org-mode
	hl(0, "@org.keyword.todo",     { fg   = colors.base08, bold = true })
	hl(0, "@org.keyword.done",     { fg   = colors.base0B, bold = true })
	hl(0, "@org.headline.level1",  { fg   = colors.base08, bold = true })
	hl(0, "@org.headline.level2",  { fg   = colors.base09, bold = true })
	hl(0, "@org.headline.level3",  { fg   = colors.base0A, bold = true })
	hl(0, "@org.headline.level4",  { fg   = colors.base0B, bold = true })
	hl(0, "@org.headline.level5",  { fg   = colors.base0C, bold = true })
	hl(0, "@org.headline.level6",  { fg   = colors.base0D, bold = true })
	hl(0, "@org.headline.level7",  { fg   = colors.base0E, bold = true })
	hl(0, "@org.headline.level8",  { fg   = colors.base0F, bold = true })
	hl(0, "@org.agenda.deadline",  { link = "ErrorMsg" })
	hl(0, "@org.agenda.scheduled", { link = "Normal" })
	hl(0, "@org.strikethrough",    { strikethrough = true })

	-- Snacks
	hl(0, "SnacksPickerPreview", {  bg = colors.base01 })
	hl(0, "SnacksPickerBorder", { fg = colors.base03, bg =  colors.base02 })
	hl(0, "SnacksPickerBoxBorder", { link = "FloatBorder"})
	hl(0, "SnacksPickerListCursorline", { link = "PmenuSel"})
	hl(0, "SnacksPickerPreviewBorder", {  fg = colors.base01, bg = colors.base01 })

	-- Minifiles
	hl(0, "MiniFilesBorderModified", {  fg = colors.base08, bg = colors.base02 })

	-- MiniJump2d
	hl(0, 'MiniJump2dSpot', { fg = colors.base00, bg = colors.base08, bold = true })
end

return M
