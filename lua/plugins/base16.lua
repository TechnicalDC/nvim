return {
	'RRethy/base16-nvim',
	config = function()
		require('base16-colorscheme').with_config({
			telescope = true,
			telescope_borders = true,
			indentblankline = true,
			notify = true,
			ts_rainbow = true,
			cmp = true,
			illuminate = true,
			dapui = true,
		})
		require('matugen').setup()

		local hl = vim.api.nvim_set_hl
		local colors = require('base16-colorscheme').colors

		hl(0, "Normal",									  { bg = "none" })
		hl(0, "NormalNC",									  { bg = "none" })
		hl(0, "NormalFloat",								  { link = "Normal" })
		hl(0, "SignColumn",								  { link = "Normal" })
		hl(0, "FloatBorder",                        { fg   = colors.base03, bg   = "none"        })
		hl(0, "FloatTitle",                         { bg = "none",          fg   = colors.base08 })
		hl(0, "WinSeparator",                       { fg = colors.base02 })
		hl(0, "StatusLineMode",                     { fg   = colors.base00, bg   = colors.base08, bold = true })
		hl(0, "StatusLine",                         { fg = colors.base03 })
		hl(0, "Winbar", 									  { link = "StatusLine"})
		hl(0, "WinbarNC", 								  { link = "StatusLine"})
		hl(0, "TabLineFill",                        { link = "StatusLine" })
		hl(0, "TabLineSel",                         { link = "StatusLineMode" })
		hl(0, "LineNr",                             { fg = colors.base03 })
		hl(0, "CursorLineNr",                       { bg   = "none", bold = true })
		hl(0, "NeogitFoldColumn",                   { link = "SignColumn" })
		hl(0, "FoldColumn",                         { bg   = colors.base01 })
		hl(0, "DiagnosticUnderlineError",           { undercurl = true })
		hl(0, "DiagnosticUnderlineHint",            { undercurl = true })
		hl(0, "DiagnosticUnderlineInfo",            { undercurl = true })
		hl(0, "DiagnosticUnderlineOk",              { undercurl = true })
		hl(0, "DiagnosticUnderlineWarn",            { undercurl = true })
		hl(0, "Comment",                            { fg = colors.base03,   italic = true })
		hl(0, "TelescopeBorder",                    { link = "FloatBorder"  })
		hl(0, "TelescopeMatching",                    { fg = colors.base0C, bold = true })
		hl(0, "TelescopeNormal",                    { link = "NormalFloat"  })
		hl(0, "TelescopePromptNormal",                    { link = "NormalFloat"  })
		hl(0, "TelescopePromptBorder",              { link = "FloatBorder"  })
		hl(0, "TelescopePromptTitle",               { link = "FloatTitle"  })
		hl(0, "TelescopePreviewTitle",               { link = "FloatTitle"  })
		hl(0, "TelescopePromptPrefix",              { link = "FloatTitle"  })
		hl(0, "TelescopeTitle",                     { link = "FloatTitle"   })
		hl(0, "@org.keyword.todo",                  { fg   = colors.base08, bold = true          })
		hl(0, "@org.keyword.done",                  { fg   = colors.base0B, bold = true          })
		hl(0, "@org.headline.level1",               { fg   = colors.base08, bold = true          })
		hl(0, "@org.headline.level2",               { fg   = colors.base09, bold = true          })
		hl(0, "@org.headline.level3",               { fg   = colors.base0A, bold = true          })
		hl(0, "@org.headline.level4",               { fg   = colors.base0B, bold = true          })
		hl(0, "@org.headline.level5",               { fg   = colors.base0C, bold = true          })
		hl(0, "@org.headline.level6",               { fg   = colors.base0D, bold = true          })
		hl(0, "@org.headline.level7",               { fg   = colors.base0E, bold = true          })
		hl(0, "@org.headline.level8",               { fg   = colors.base0F, bold = true          })
		hl(0, "@markup.link.label.markdown_inline", { fg = colors.base0E,   underline = true })
		hl(0, "Pmenu",                              { fg   = colors.base05, bg   = "none"        })
		hl(0, "PmenuSel",                           {  bg   = colors.base01        })
		hl(0, "MiniStarterSection",                 {  fg   = colors.base0B        })
		hl(0, "MiniTablineFill",                    { link = "TabLineFill" })
		hl(0, "MiniTablineModifiedCurrent",			  { link = "MiniTablineCurrent"})
	end,
}
