return {
	'nvim-orgmode/orgmode',
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"chipsenkbeil/org-roam.nvim",
		"akinsho/org-bullets.nvim",
		"nvim-orgmode/telescope-orgmode.nvim",
	},
	config = function()
		local org = require('orgmode')

		-- org.setup_ts_grammar()
		org.setup({
			org_ellipsis = " [...]",
			org_hide_emphasis_markers = true,
			org_agenda_files = '~/orgfiles/**/*',
			org_agenda_span = "day",
			org_agenda_start_on_weekday = 0,
			org_todo_keywords = {'TODO(t)', 'WAITING(w)', '|', 'PROGRESS(p)', 'DONE(d)'},
			org_capture_templates = {
				t = {
					description = 'Todo',
					template = '* TODO %?',
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
					template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n%?',
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
						-- your handler here, for example:
						local options = {}
						local options_by_label = {}

						for _, item in ipairs(data.items) do
							-- Only MenuOption has `key`
							-- Also we don't need `Quit` option because we can close the menu with ESC
							if item.key and item.label:lower() ~= "quit" then
								table.insert(options, item.label)
								options_by_label[item.label] = item
							end
						end

						local handler = function(choice)
							if not choice then
								return
							end

							local option = options_by_label[choice]
							if option.action then
								option.action()
							end
						end

						vim.ui.select(options, {
							prompt = data.title,
						}, handler)
					end,
				},
			},
		})
		require("org-roam").setup({
			directory = "~/orgfiles/roam",
		})
		require('org-bullets').setup()
		require("telescope").load_extension("orgmode")

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
