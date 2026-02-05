-- lua/plugins/rose-pine.lua
return {
   "rose-pine/neovim",
   name = "rose-pine",
   enabled = false,
   config = function()
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
            RenderMarkdownH1Bg = { bg = "none" },
            RenderMarkdownH2Bg = { bg = "none" },
            RenderMarkdownH3Bg = { bg = "none" },
            RenderMarkdownH4Bg = { bg = "none" },
            RenderMarkdownH5Bg = { bg = "none" },
            RenderMarkdownH6Bg = { bg = "none" },

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

            MiniHipatternsDone     = { fg = "pine", bg = "none" },
            MiniHipatternsPending  = { fg = "love", bg = "none" },
            MiniHipatternsProgress = { fg = "gold", bg = "none" },
            MiniHipatternsFixme    = { fg = "love", bg = "none" },
            MiniHipatternsTodo     = { fg = "iris", bg = "none" },
            MiniHipatternsNote     = { fg = "foam", bg = "none" },
            MiniHipatternsDebug    = { fg = "gold", bg = "none" },

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

      -- vim.cmd.colorscheme("rose-pine")
   end
}
