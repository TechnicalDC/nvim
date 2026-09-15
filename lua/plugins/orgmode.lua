return {
	'nvim-orgmode/orgmode',
	dependencies = {
		"chipsenkbeil/org-roam.nvim",
		"akinsho/org-bullets.nvim",
	},
	config = function()
		local org = require('orgmode')

		org.setup({
			org_ellipsis = " [...]",
			org_hide_emphasis_markers = true,
			org_hide_leading_stars = true,
			org_agenda_files = '~/orgfiles/**/*',
			-- org_agenda_span = "day",
			org_agenda_start_on_weekday = 0,
			org_todo_keywords = {"TODO(t)", "PROJ(P)", "PROGRESS(p)", "WAIT(w)", "HOLD(h)", "TEST(T)", "|", "CANCELLED(c)", "DONE(d)"},
			org_agenda_use_time_grid = false,
			win_border = "single",
			win_split_mode = "auto",
			org_capture_templates = {
				t = {
					description = 'Todo',
					template = '* TODO %?',
					headling = "Todos",
					target = "~/orgfiles/todo.org"
				},
				T = {
					description = 'Development Task',
					template = '* TODO %?\n%i\n%a',
					headling = "Tasks",
					target = "~/orgfiles/todo.org"
				},
				j = {
					description = 'Journal',
					template = '\t\t- %?',
					target = '~/orgfiles/journal/%<%Y-%m>.org',
					datetree = {
						tree_type = "day",
						time_prompt = true
					},
				},
				m = {
					description = 'Meeting',
					subtemplates = {
						r = {
							description = 'Recurring Meeting',
							template = '* TODO %?\nSCHEDULED:%^t',
							target = "~/orgfiles/meetings.org",
							headline = 'recurring'
						},
						o = {
							description = 'One-time Meeting',
							template = '* TODO %?\nSCHEDULED:%^t',
							target = "~/orgfiles/meetings.org",
							headline = 'one-time'
						},
					},
				},
			},
			org_default_notes_file = '~/orgfiles/notes.org',
			calendar_week_start_day = 0,
			ui = {
				input = { use_vim_ui = true },
			}
		})
		require("org-roam").setup({
			directory = "~/orgfiles/roam",
			templates = {
				d = {
					description = "default",
					template = "%?",
					target = "${slug}.org",
				},
			},
			extensions = {
				dailies = {
					templates = {
						d = {
							description = "default",
							template = "* %?",
							target = "%<%Y-%m-%d>.org",
						},
					},
				},
			},
		})

		require('org-bullets').setup({
			symbols = {
				headlines = { '󰲡', '󰲣', '󰲥', '󰲧', '󰲩', '󰲫' },
				checkboxes = {
					half = { "󰪡", "@org.checkbox.halfchecked" },
					done = { "󰪥", "@org.keyword.done" },
					todo = { "󰄰", "@org.keyword.todo" },
				},
			}
		})

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
