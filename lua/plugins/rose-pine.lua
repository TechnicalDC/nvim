-- lua/plugins/rose-pine.lua
return {
   "rose-pine/neovim",
   name = "rose-pine",
   config = function()
      local transparency = false
      require("rose-pine").setup({
         highlight_groups = {
            StatusLine            = { fg = "subtle", bg  = "surface" },
            StatusLineTerm        = { fg = "subtle", bg  = "surface" },
            StatusLineMode        = { fg = "surface", bg = "iris", bold = true },
            StatusLineModeNormal  = { fg = "surface", bg = "love", bold = true },
            StatusLineModeVisual  = { fg = "surface", bg = "rose", bold = true },
            StatusLineModeInsert  = { fg = "surface", bg = "foam", bold = true },
            StatusLineModeCommand = { fg = "surface", bg = "gold", bold = true },

            ["@markup.link.label.markdown_inline"] = { fg = "foam", underline = true },

            RenderMarkdownUnchecked = { fg = "love" },

            BlinkCmpSource          = { bg   = "none" },

            Folded                  = { link = "Comment" },
            NormalFloat             = { link = "Normal" },
            FloatBorder             = {
               fg = "highlight_high",
               bg = "none"
            },
            FloatTitle = { fg = "love", bg = "none" },

            MiniFilesTitleFocused    = { fg   = "love", bg = "none" },
            MiniClueTitle            = { link = "FloatTitle" },
            MiniPickHeader           = { link = "FloatTitle" },
            MiniPickBorderText       = { link = "FloatTitle" },
            MiniPickPromptPrefix     = { link = "FloatTitle" },
            MiniStarterHeader        = { fg = "love" },
            MiniTablineModifiedCurrent = { bg = "love" },
            MiniTablineModifiedVisible = { fg = "love", bg = "love", blend = 30 },
            MiniTablineModifiedHidden  = { fg = "love", bg = "love", blend = 20 },

            NoiceCmdline               = { link = "StatusLine" },
            NoiceCmdlineIcon           = { link = "StatusLineModeInsert" },
            NoiceCmdlineIconCmdline    = { link = "StatusLineModeInsert" },
            NoiceCmdlineIconCalculator = { link = "StatusLineModeInsert" },
            NoiceCmdlineIconFilter     = { link = "StatusLineModeInsert" },
            NoiceCmdlineIconLua        = { link = "StatusLineModeInsert" },
            NoiceCmdlineIconInput      = { link = "StatusLineModeInsert" },
            NoiceCmdlineIconHelp       = { link = "StatusLineModeInsert" },
            NoiceCmdlineIconSearch     = { link = "StatusLineModeInsert" },
         },
      })

      vim.cmd.colorscheme("rose-pine")
   end
}
