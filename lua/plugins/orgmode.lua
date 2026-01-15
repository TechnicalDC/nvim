return {
   'nvim-orgmode/orgmode',
   dependencies = { "chipsenkbeil/org-roam.nvim" },
   config = function()
      require('orgmode').setup({
         org_agenda_files = '~/orgfiles/**/*',
         org_default_notes_file = '~/orgfiles/refile.org',
      })
      require("org-roam").setup({
         directory = "~/orgfiles",
      })
   end,
}
