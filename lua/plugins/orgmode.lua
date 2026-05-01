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
		local Menu = require("org-modern.menu")
		local org = require('orgmode')

		-- org.setup_ts_grammar()
		org.setup({
			org_ellipsis = " [...]",
			org_hide_emphasis_markers = true,
			-- win_split_mode = function(name)
			-- 	-- Make sure it's not a scratch buffer by passing false as 2nd argument
			-- 	local bufnr = vim.api.nvim_create_buf(false, false)
			-- 	--- Setting buffer name is required
			-- 	vim.api.nvim_buf_set_name(bufnr, name)
			--
			-- 	local fill = 0.5
			-- 	local width = math.floor((vim.o.columns * fill))
			-- 	local height = math.floor((vim.o.lines * fill))
			-- 	local row = math.floor((((vim.o.lines - height) / 2) - 1))
			-- 	local col = math.floor(((vim.o.columns - width) / 2))
			--
			-- 	vim.api.nvim_open_win(bufnr, true, {
			-- 		relative = "editor",
			-- 		width = width,
			-- 		height = height,
			-- 		row = row,
			-- 		col = col,
			-- 		style = "minimal",
			-- 		border = "rounded"
			-- 	})
			-- end,
			org_agenda_files = '~/orgfiles/**/*',
			org_agenda_span = "day",
			org_agenda_start_on_weekday = 0,
			org_todo_keywords = {'TODO(t)', 'WAIT(w)', '|', 'PROG(p)', 'DONE(d)'},
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
						data.title = " " .. data.title .. " "
						Menu:new({
							window = {
								margin = { 1, 0, 1, 0 },
								padding = { 0, 1, 0, 1 },
								title_pos = "center",
								border = vim.o.winborder,
								zindex = 1000,
							},
							icons = {
								separator = "│",
							},
						}):open(data)
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

		-- vim.api.nvim_create_autocmd('FileType', {
		-- 	pattern = 'orgagenda',
		-- 	callback = function(args)
		-- 		vim.wo[args.data.win_id].number = false
		-- 		vim.wo[args.data.win_id].relativenumber = false
		-- 	end,
		-- })
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
