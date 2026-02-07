return {
	'nvim-orgmode/orgmode',
	dependencies = {
		"chipsenkbeil/org-roam.nvim",
		"akinsho/org-bullets.nvim",
		"danilshvalov/org-modern.nvim",
	},
	config = function()
		local Menu = require("org-modern.menu")
		local org = require('orgmode')

		-- org.setup_ts_grammar()
		org.setup({
			org_ellipsis = " ",
			org_agenda_files = '~/orgfiles/**/*',
			org_agenda_span = "day",
			org_agenda_start_on_weekday = 0,
			org_capture_templates = {
				t = {
					description = 'Todo',
					template = '** TODO %?',
					target = "~/orgfiles/todo.org"
				},
				n = {
					description = 'Note',
					template = '** %?',
					target = "~/orgfiles/notes.org"
				},
				j = {
					description = 'Journal',
					template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
					target = '~/orgfiles/journal/%<%Y-%m>.org'
				},
			},
			org_default_notes_file = '~/orgfiles/refile.org',
			calendar_week_start_day = 0,
			ui = {
				input = {
					use_vim_ui = true
				},
				menu = {
					handler = function(data)
						Menu:new({
							window = {
								margin = { 1, 0, 1, 0 },
								padding = { 0, 1, 0, 1 },
								title_pos = "left",
								border = "single",
								zindex = 1000,
							},
							icons = {
								separator = "",
							},
						}):open(data)
					end,
				},
			},
		})
		require("org-roam").setup({
		   directory = "~/orgfiles/notes",
		})
		require('org-bullets').setup()

		-- Experimental LSP support
		vim.lsp.enable('org')

		vim.api.nvim_create_autocmd('FileType', {
			pattern = 'org',
			callback = function()
				vim.keymap.set('i', '<S-CR>', '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
					silent = true,
					buffer = true,
				})
			end,
		})
	end,
}
