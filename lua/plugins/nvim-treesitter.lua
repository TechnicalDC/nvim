return {
   'nvim-treesitter/nvim-treesitter',
   enabled = true,
   build = ':TSUpdate',
   config = function ()
      require'nvim-treesitter'.setup {
         ensure_installed = {
            "bash",
            "css",
            "diff",
            "java",
            "json",
            "typst",
            "lua",
            "markdown",
            "markdown_inline",
            "rust",
            "typescript",
            "xml",
         },
         sync_install = true,
         auto_install = false,
         ignore_install = { "javascript" },

         highlight = {
            -- `false` will disable the whole extension
            enable = true,
            disable = { "c", "rust" },
            additional_vim_regex_highlighting = {"org"},
         },
         incremental_selection = {
            disable = {},
            enable = true,
            keymaps = {
               init_selection = "gnn",
               node_decremental = "grm",
               node_incremental = "grn",
               scope_incremental = "grc"
            },
            module_path = "nvim-treesitter.incremental_selection"
         },
      }
   end
}
