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

		hl(0, "FloatBorder",           { fg   = colors.base03, bg   = "none"        })
		hl(0, "FloatTitle",            { fg   = colors.base00, bg   = colors.base08 })
		hl(0, "WinSeparator", { fg = colors.base02 })
		hl(0, "DiagnosticUnderlineError", { undercurl = true })
		hl(0, "DiagnosticUnderlineHint",  { undercurl = true })
		hl(0, "DiagnosticUnderlineInfo",  { undercurl = true })
		hl(0, "DiagnosticUnderlineOk",    { undercurl = true })
		hl(0, "DiagnosticUnderlineWarn",  { undercurl = true })
		hl(0, "TelescopeBorder",       { link = "FloatBorder"  })
		hl(0, "TelescopePromptBorder", { link = "FloatBorder"  })
		hl(0, "TelescopeTitle",        { link = "FloatTitle"   })
		hl(0, "@org.keyword.todo",     { fg   = colors.base08, bold = true          })
		hl(0, "@org.keyword.done",     { fg   = colors.base0B, bold = true          })
		hl(0, "@markup.link.label.markdown_inline", { fg = colors.base0E, underline = true })
		hl(0, "Pmenu",           { fg   = colors.base05, bg   = "none"        })
		hl(0, "PmenuSel",           {  bg   = colors.base01        })
	end,
}
