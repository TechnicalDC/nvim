return {
	'nvim-orgmode/orgmode',
	dependencies = {
		-- "chipsenkbeil/org-roam.nvim",
		"akinsho/org-bullets.nvim",
		"danilshvalov/org-modern.nvim",
		'hamidi-dev/org-super-agenda.nvim',
	},
	config = function()
		local Menu = require("org-modern.menu")
		require('orgmode').setup({
			org_agenda_files = '~/orgfiles/**/*',
			org_agenda_start_on_weekday = 0,
			org_capture_templates = {
				t = {
					description = 'Task',
					template = '** TODO %?',
					target = "~/orgfiles/tasks.org"
				},
				n = {
					description = 'Note',
					template = '** %?',
					target = "~/orgfiles/notes.org"
				}
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
								separator = "➜",
							},
						}):open(data)
					end,
				},
			},
		})
		-- require("org-roam").setup({
		--    directory = "~/orgfiles",
		-- })
		require('org-bullets').setup()
		require('org-super-agenda').setup({
			-- Where to look for .org files
			org_files           = {},
			org_directories     = {}, -- recurse for *.org
			exclude_files       = {},
			exclude_directories = {},

			-- TODO states + their quick filter keymaps and highlighting
			-- Optional: add `shortcut` field to override the default key (first letter)
			todo_states = {
				{ name='TODO',     keymap='ot', color='#FF5555', strike_through=false, fields={'filename','todo','headline','priority','date','tags'} },
				{ name='PROGRESS', keymap='op', color='#FFAA00', strike_through=false, fields={'filename','todo','headline','priority','date','tags'} },
				{ name='WAITING',  keymap='ow', color='#BD93F9', strike_through=false, fields={'filename','todo','headline','priority','date','tags'} },
				{ name='DONE',     keymap='od', color='#50FA7B', strike_through=true,  fields={'filename','todo','headline','priority','date','tags'} },
			},

			-- Agenda keymaps (inline comments explain each)
			keymaps = {
				filter_reset      = 'oa', -- reset all filters
				toggle_other      = 'oo', -- toggle catch-all "Other" section
				filter            = 'of', -- live filter (exact text)
				filter_fuzzy      = 'oz', -- live filter (fuzzy)
				filter_query      = 'oq', -- advanced query input
				undo              = 'u',  -- undo last change
				reschedule        = 'cs', -- set/change SCHEDULED
				set_deadline      = 'cd', -- set/change DEADLINE
				cycle_todo        = 't',  -- cycle TODO state
				set_state         = 's',  -- set state directly (st, sd, etc.) or show menu
				reload            = 'r',  -- refresh agenda
				refile            = 'R',  -- refile via Telescope/org-telescope
				hide_item         = 'x',  -- hide current item
				preview           = 'K',  -- preview headline content
				reset_hidden      = 'X',  -- clear hidden list
				toggle_duplicates = 'D',  -- duplicate items may appear in multiple groups
				cycle_view        = 'ov', -- switch view (classic/compact)
			},

			-- Window/appearance
			window = {
				width        = 0.8,
				height       = 0.7,
				border       = 'single',
				title        = ' Org Super Agenda ',
				title_pos    = 'center',
				margin_left  = 0,
				margin_right = 0,
				fullscreen_border = 'none', -- border style when using fullscreen
			},

			-- Group definitions (order matters; first match wins unless allow_duplicates=true)
			groups = {
				{ name = '📅 Today',     matcher = function(i) return i.scheduled and i.scheduled:is_today() end, sort={ by='scheduled_time', order='asc' } },
				{ name = '🗓️ Tomorrow', matcher = function(i) return i.scheduled and i.scheduled:days_from_today() == 1 end, sort={ by='scheduled_time', order='asc' } },
				{ name = '☠️ Deadlines', matcher = function(i) return i.deadline and i.todo_state ~= 'DONE' and not i:has_tag('personal') end, sort={ by='deadline', order='asc' } },
				{ name = '⭐ Important',  matcher = function(i) return i.priority == 'A' and (i.deadline or i.scheduled) end, sort={ by='date_nearest', order='asc' } },
				{ name = '⏳ Overdue',    matcher = function(i) return i.todo_state ~= 'DONE' and ((i.deadline and i.deadline:is_past()) or (i.scheduled and i.scheduled:is_past())) end, sort={ by='date_nearest', order='asc' } },
				{ name = '🏠 Personal',   matcher = function(i) return i:has_tag('personal') end },
				{ name = '💼 Work',       matcher = function(i) return i:has_tag('work') end },
				{ name = '📆 Upcoming',   matcher = function(i)
					local days = require('org-super-agenda.config').get().upcoming_days or 10
					local d1 = i.deadline  and i.deadline:days_from_today()
					local d2 = i.scheduled and i.scheduled:days_from_today()
					return (d1 and d1 >= 0 and d1 <= days) or (d2 and d2 >= 0 and d2 <= days)
				end,
				sort={ by='date_nearest', order='asc' }
			},
		},

		-- Defaults & behavior
		upcoming_days      = 10,
		hide_empty_groups  = true,      -- drop blank sections
		keep_order         = false,     -- keep original org order (rarely useful)
		allow_duplicates   = false,     -- if true, an item can live in multiple groups
		group_format       = '* %s',    -- group header format
		other_group_name   = 'Other',
		show_other_group   = false,     -- show catch-all section
		show_tags          = true,      -- draw tags on the right
		show_filename      = true,      -- include [filename]
		heading_max_length = 70,
		persist_hidden     = false,     -- keep hidden items across reopen
		view_mode          = 'classic', -- 'classic' | 'compact'

		classic = { heading_order={'filename','todo','priority','headline'}, short_date_labels=false, inline_dates=true },
		compact = { filename_min_width=10, label_min_width=12 },

		-- Global fallback sort for groups that omit `sort`
		group_sort = { by='date_nearest', order='asc' },

		-- Popup mode: run in a persistent tmux session for instant access
		popup_mode = {
			enabled      = false,
			hide_command = nil, -- e.g., "tmux detach-client"
		},

		debug = false,
	})

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
