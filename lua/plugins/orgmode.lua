return {
	'nvim-orgmode/orgmode',
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"chipsenkbeil/org-roam.nvim",
		"akinsho/org-bullets.nvim",
		"danilshvalov/org-modern.nvim",
		"nvim-orgmode/telescope-orgmode.nvim",
	},
	config = function()
		local org = require('orgmode')
		local Menu = require("org-modern.menu")

		-- org.setup_ts_grammar()
		org.setup({
			org_ellipsis = " [...]",
			org_hide_emphasis_markers = true,
			org_agenda_files = '~/orgfiles/**/*',
			org_agenda_span = "day",
			org_agenda_start_on_weekday = 0,
			org_todo_keywords = {'TODO(t)', 'WAITING(w)', '|', 'PROGRESS(p)', 'DONE(d)'},
			org_agenda_use_time_grid = false,
			win_border = "rounded",
			org_capture_templates = {
				t = {
					description = 'Todo',
					template = '* TODO %?',
					headling = "TEST",
					target = "~/orgfiles/todo.org"
				},
				T = {
					description = 'Task',
					template = '* TODO %?\n  SCHEDULED: %^t\n  [[%F]]\n',
					target = "~/orgfiles/tasks.org"
				},
				m = {
					description = 'Meeting',
					template = '* TODO %?\n  SCHEDULED: %^t',
					target = "~/orgfiles/meetings.org"
				},
				n = {
					description = 'Note',
					template = '* %?',
					target = "~/orgfiles/notes.org"
				},
				j = {
					description = 'Journal',
					template = '\t\t%?',
					target = '~/orgfiles/journal/%<%Y-%m>.org',
					datetree = { tree_type = "day" },
				},
				e = {
					description = 'Event',
					subtemplates = {
						r = {
							description = 'recurring',
							template = '** %?\n %T',
							target = '~/orgfiles/calendar.org',
							headline = 'recurring'
						},
						o = {
							description = 'one-time',
							template = '** %?\n %T',
							target = '~/orgfiles/calendar.org',
							headline = 'one-time'
						},
					},
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
						data.title = " " .. data.title .. " "
						Menu:new({
							window = {
								margin = { 1, 0, 1, 0 },
								padding = { 0, 1, 0, 1 },
								title_pos = "center",
								border = "rounded",
								zindex = 1000,
							},
							icons = {
								separator = "|",
							},
						}):open(data)
					end,
				},
			}
		})
		require("org-roam").setup({
			directory = "~/orgfiles/roam",
		})
		require('org-bullets').setup()
		require("telescope").load_extension("orgmode")
		require("telescope-orgmode").setup({
			picker_defaults = {
				search_headings = { preview = false },
				search_tags = { preview = false },
				insert_link = { preview = false },
			},
		})

		local ext = require("telescope").extensions.orgmode
		vim.keymap.set("n", "<leader>fH", ext.search_headings, { desc = "Org headlines" })
		vim.keymap.set("n", "<leader>fT", ext.search_tags, { desc = "Org tags" })
		vim.keymap.set("n", "<leader>rh", ext.refile_heading, { desc = "Org refile" })
		vim.keymap.set("n", "<leader>li", ext.insert_link, { desc = "Org insert link" })

		-- Experimental LSP support
		vim.lsp.enable('org')

		vim.api.nvim_create_autocmd('FileType', {
			pattern = 'orgagenda',
			command = "setlocal nonumber norelativenumber"
		})
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
