
return {
   "williamboman/mason.nvim",
   dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
   },
   event = { "BufReadPre", "BufNewFile" },
   config = function ()
      require("mason").setup()
      require("mason-lspconfig").setup({
         ensure_installed = {
            "lua_ls",
            "tinymist",
            "marksman",
            "jdtls",
         }
      })
      require("dc.config.lsp")
   end
}
