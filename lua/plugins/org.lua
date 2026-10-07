-- ~/.config/nvim/lua/plugins/org.lua
return {
	"xheisenbugx/org.nvim",
	main = "org",
	lazy = false, -- startup cost is tiny: only :Org and a few global keymaps
	keys = {
		{ "<leader>oc", "<cmd>Org capture<cr>", desc = "Org: capture" },
		{ "<leader>oa", "<cmd>Org agenda<cr>", desc = "Org: agenda" },
	},
	opts = {
		org_directory = "~/orgfiles/",
		agenda_files = { "~/orgfiles/", "~/orgfiles/journal/" },
		default_notes_file = "~/orgfiles/notes.org",
		win_split_mode = "auto",
		win_border = "single",
		ellipsis = " ...",
		span = "week",
		start_on_weekday = 0,
		todo_keywords = {"TODO(t)", "PROGRESS(p)", "WAIT(w)", "HOLD(h)", "TEST(T)", "|", "CANCELLED(c)", "DONE(d)"},
		ui = {
			--- Hide *, /, _, =, ~, + around emphasized text (org-hide-emphasis-markers).
			hide_emphasis_markers = true,
			--- Show only the last star of each headline (org-hide-leading-stars;
			--- #+STARTUP: hidestars / showstars).
			hide_leading_stars = true,
			--- Replace headline stars with symbols. false or list per level.
			bullets = true, -- e.g. { "◉", "○", "✸", "✿" }
			indent_mode = true,
		},
		capture = {
			templates = {
				t = {
					description = 'Todo',
					template = '* TODO %?',
					type = "entry",
					headline = "Todos",
					target = "~/orgfiles/todo.org"
				},
				T = {
					description = 'Development Task',
					template = '* TODO %?\n%i\n%a',
					headline = "Tasks",
					type = "entry",
					target = "~/orgfiles/todo.org"
				},
				j = {
					description = 'Journal',
					type = "entry",
					template = '* %<%H:%M> %?',
					target = function ()
						return '~/orgfiles/journal/' .. os.date("%Y-%m") .. '.org'
					end,
					datetree = {
						tree_type = "day",
						time_prompt = true
					},
				},
				m = "Meeting",
				mr = {
					description = 'Recurring Meeting',
					template = '* TODO %?\nSCHEDULED: %^t',
					target = "~/orgfiles/meetings.org",
					headline = 'Recurring Meetings'
				},
				mo = {
					description = 'One-time Meeting',
					template = '* TODO %?\nSCHEDULED: %^t',
					target = "~/orgfiles/meetings.org",
					headline = 'One-time Meetings'
				}
			},
			window = "split",
		},
		agenda = {
			save_after_edit = true,
			window = "current",
			block_separator = " ",
			skip_scheduled_if_done = true,
			skip_deadline_if_done = true,
			skip_timestamp_if_done = true,
			holidays = {
				general = {
					{"holiday-fixed", 1, 26, "Republic Day"},
					{"holiday-fixed", 8, 15, "Independence Day"},
					{"holiday-fixed", 10, 20, "Ayudha Pooja"},
					{"holiday-fixed", 10, 21, "Vijayadasami"},
					{"holiday-fixed", 11, 10, "Deepawali"},
				},
				islamic = {},
				christian = {
					{"holiday-fixed", 12, 25, "Christmas"}
				},
				hebrew = {},
				bahai = {},
				oriental = {},
				solar = {}
			},
			custom_commands = {
				-- a block agenda: three views in one buffer
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
						{
							type = 'agenda',
							org_agenda_overriding_header = 'Whole week overview',
							org_agenda_span = 'week', -- 'week' is default, so it's not necessary here, just an example
							org_agenda_start_on_weekday = 1, -- Start on Monday
							org_agenda_remove_tags = true -- Do not show tags only for this view
						},
					}
				},
				-- a single tags view
				n = {
					description = "Today's Agenda & All todos",
					types = {
						{
							type = 'agenda',
							org_agenda_overriding_header = 'My daily agenda',
							org_agenda_span = 'day', -- can be any value as org_agenda_span
							org_agenda_skip_scheduled_if_done = true,
							org_agenda_skip_deadline_if_done = true,
							org_agenda_skip_timestamp_if_done = true,
						},
						{
							type = 'tags_todo', -- Type can be agenda | tags | tags_todo
							org_agenda_overriding_header = 'All Todos',
							org_agenda_todo_ignore_deadlines = 'far', -- Ignore all deadlines that are too far in future (over org_deadline_warning_days). Possible values: all | near | far | past | future
							org_agenda_todo_ignore_scheduled = true,
							org_agenda_todo_ignore_timestamp  = true,
						},
					}
				},
				u = { description = "Urgent", type = "tags", match = 'PRIORITY="A"|+urgent' },
			},
		},
		extensions = {
			roam = { directory = "~/orgfiles/roam/" },
			pomodoro = true,
			code = true,
			kanban = true,
			timeline = true,
			sidebar = true,
		}
	},
}
