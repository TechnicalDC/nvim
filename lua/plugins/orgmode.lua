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
			org_agenda_skip_scheduled_if_done = true,
			org_agenda_skip_deadline_if_done = true,
			win_border = "single",
			win_split_mode = "auto",
			org_capture_templates = {
				t = {
					description = 'Todo',
					template = '* TODO %?',
					headline = "Todos",
					target = "~/orgfiles/todo.org"
				},
				T = {
					description = 'Development Task',
					template = '* TODO %?\n%i\n%a',
					headline = "Tasks",
					target = "~/orgfiles/todo.org"
				},
				j = {
					description = 'Journal',
					template = '- %?',
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
							headline = 'Recurring Meetings'
						},
						o = {
							description = 'One-time Meeting',
							template = '* TODO %?\nSCHEDULED:%^t',
							target = "~/orgfiles/meetings.org",
							headline = 'One-time Meetings'
						},
					},
				},
			},
			org_default_notes_file = '~/orgfiles/notes.org',
			calendar_week_start_day = 0,
			org_agenda_custom_commands = {
				-- "c" is the shortcut that will be used in the prompt
				c = {
					description = 'Combined view', -- Description shown in the prompt for the shortcut
					types = {
						{
							type = 'tags_todo', -- Type can be agenda | tags | tags_todo
							match = '+PRIORITY="A"', --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
							org_agenda_overriding_header = 'High priority todos',
							org_agenda_todo_ignore_deadlines = 'far', -- Ignore all deadlines that are too far in future (over org_deadline_warning_days). Possible values: all | near | far | past | future
						},
						{
							type = 'agenda',
							org_agenda_overriding_header = 'My daily agenda',
							org_agenda_span = 'day' -- can be any value as org_agenda_span
						},
						-- {
						-- 	type = 'tags',
						-- 	match = 'WORK', --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
						-- 	org_agenda_overriding_header = 'My work todos',
						-- 	org_agenda_todo_ignore_scheduled = 'all', -- Ignore all headlines that are scheduled. Possible values: past | future | all
						-- },
						{
							type = 'agenda',
							org_agenda_overriding_header = 'Whole week overview',
							org_agenda_span = 'week', -- 'week' is default, so it's not necessary here, just an example
							org_agenda_start_on_weekday = 1, -- Start on Monday
							org_agenda_remove_tags = true -- Do not show tags only for this view
						},
					}
				},
				n = {
					description = "Today's Agenda & All todos",
					types = {}
				}
				-- p = {
				-- 	description = 'Personal agenda',
				-- 	types = {
				-- 		{
				-- 			type = 'tags_todo',
				-- 			org_agenda_overriding_header = 'My personal todos',
				-- 			org_agenda_category_filter_preset = 'todos', -- Show only headlines from `todos` category. Same value providad as when pressing `/` in the Agenda view
				-- 			org_agenda_sorting_strategy = {'todo-state-up', 'priority-down'} -- See all options available on org_agenda_sorting_strategy
				-- 		},
				-- 		{
				-- 			type = 'agenda',
				-- 			org_agenda_overriding_header = 'Personal projects agenda',
				-- 			org_agenda_files = {'~/my-projects/**/*'}, -- Can define files outside of the default org_agenda_files
				-- 		},
				-- 		{
				-- 			type = 'tags',
				-- 			org_agenda_overriding_header = 'Personal projects notes',
				-- 			org_agenda_files = {'~/my-projects/**/*'},
				-- 			org_agenda_tag_filter_preset = 'NOTES-REFACTOR' -- Show only headlines with NOTES tag that does not have a REFACTOR tag. Same value providad as when pressing `/` in the Agenda view
				-- 		},
				-- 	}
				-- }
			},
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
