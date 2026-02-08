local palette = require("mini.hues").make_palette()
local hl = vim.api.nvim_set_hl

-- print(vim.inspect(palette))

hl(0, "NormalFloat",         { fg = palette.fg,      bg = palette.bg_edge })
hl(0, "FloatBorder",         { fg = palette.bg_edge, bg = palette.bg_edge })
hl(0, "FloatTitle",          { fg = palette.bg,   bg = palette.azure })
hl(0, "PmenuKind",           { bg = "None" })
hl(0, "MiniPickMatchRanges", { fg = palette.green,   bg = "None"})

hl(0, "StatusLine",            { fg = palette.fg_mid, bg = palette.bg_edge })
hl(0, "StatusLineNC",          { fg = palette.fg_mid, bg = palette.bg_mid })
hl(0, "StatusLineTerm",        { fg = palette.fg_mid, bg = "None" })
hl(0, "StatusLineTermNC",      { fg = palette.fg_mid, bg = "None" })
hl(0, "WinBar",                { fg = palette.fg_mid, bg = "None" })
hl(0, "WinBarNC",              { fg = palette.fg_mid, bg = "None" })

-- BUILT-IN
hl(0, "Msg", { link = "StatusLine" })
hl(0, "Pmenu", { bg = palette.bg_edge })
hl(0, "WinSeparator",             { fg = palette.bg_mid })
hl(0, "PmenuSel",                 { fg = palette.fg, bg = palette.bg_mid2 })
hl(0, "DiagnosticUnderlineError", { undercurl = true })
hl(0, "DiagnosticUnderlineHint",  { undercurl = true })
hl(0, "DiagnosticUnderlineInfo",  { undercurl = true })
hl(0, "DiagnosticUnderlineOk",    { undercurl = true })
hl(0, "DiagnosticUnderlineWarn",  { undercurl = true })
hl(0, "@markup.link.label.markdown_inline", { fg = palette.cyan, underline = true })

-- BLINK-CMP
hl(0, "BlinkCmpSource", { fg = palette.fg_mid2 })

-- MINI-STARTER
hl(0, "MiniStarterHeader", { fg = palette.fg_edge})
hl(0, "MiniStarterItem", { fg = palette.fg_mid2})
hl(0, "MiniStarterSection", { fg = palette.fg_edge})
hl(0, "MiniStarterItemPrefix", { fg = palette.fg_mid})

-- MINI-FILES
hl(0, "MiniFilesTitle", { link = "FloatTitle" })
hl(0, "MiniFilesTitleFocused", { fg = palette.bg,   bg = palette.azure })
hl(0, "MiniFilesBorderModified", { link = "FloatBorder" })

-- MINI-PICK
hl(0, "MiniPickPrompt",       { link = "FloatTitle" })
hl(0, "MiniPickPromptPrefix", { link = "FloatTitle" })
hl(0, "MiniPickPromptCaret",  { link = "FloatTitle" })
hl(0, "MiniPickMatchCurrent", { link = "PmenuSel" })

hl(0, "MiniNotifyBorder", { link = "FloatBorder" })

-- MINI-CLUE
hl(0, "MiniClueDescGroup", { fg = palette.yellow })
hl(0, "MiniClueSeparator", { fg = palette.blue })
hl(0, "MiniClueNextKey", { fg = palette.cyan })

-- RENDER-MARKDOWN
hl(0, "RenderMarkdownUnchecked", { fg = palette.red })
hl(0, "RenderMarkdownH1Bg", { fg = palette.orange })
hl(0, "RenderMarkdownH2Bg", { fg = palette.yellow })
hl(0, "RenderMarkdownH3Bg", { fg = palette.green  })
hl(0, "RenderMarkdownH4Bg", { fg = palette.cyan   })
hl(0, "RenderMarkdownH5Bg", { fg = palette.azure  })
hl(0, "RenderMarkdownH6Bg", { fg = palette.blue   })

-- MINI-HIPATTERN
hl(0, "MiniHipatternsDone"     , { fg = palette.green })
hl(0, "MiniHipatternsPending"  , { fg = palette.red })
hl(0, "MiniHipatternsProgress" , { fg = palette.blue })
hl(0, "MiniHipatternsFixme"    , { fg = palette.red })
hl(0, "MiniHipatternsTodo"     , { fg = palette.yellow })
hl(0, "MiniHipatternsNote"     , { fg = palette.blue })
hl(0, "MiniHipatternsDebug"    , { fg = palette.orange })

hl(0,"MiniPickHeader", { link = "FloatTitle" })
hl(0,"MiniPickBorderText", { link = "FloatTitle" })
hl(0,"MiniPickPromptPrefix", { link = "FloatTitle" })
hl(0,"MiniStarterHeader", { fg = palette.purple })
-- MiniTablineModifiedCurrent = { bg = "love" },
-- MiniTablineModifiedVisible = { fg = "love", bg = "love", blend = 30 },
-- MiniTablineModifiedHidden  = { fg = "love", bg = "love", blend = 20 },
