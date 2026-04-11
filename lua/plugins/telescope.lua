return {
	'nvim-telescope/telescope.nvim', version = '*',
	dependencies = {
		'nvim-lua/plenary.nvim',
		-- optional but recommended
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	},
	cmd = "Telescope",
	keys = {
		{ "<leader>fb",  "<cmd>Telescope buffers<cr>",      desc = "Open buffers" },
		{ "<leader>fr",  "<cmd>Telescope oldfiles<cr>",      desc = "Open recent files" },
		{ "<leader>fhi", "<cmd>Telescope highlights<cr>",      desc = "Open highlights" },
		{ "<leader>ff",  "<cmd>Telescope find_files<cr>",   desc = "Open files" },
		{ "<leader>fc",  "<cmd>Telescope colorschemes<cr>", desc = "Change colorscheme" },
		{ "<leader>ft",  "<cmd>Telescope filetypes<cr>",    desc = "Change filetype" },
		{ "<leader>fs",  "<cmd>Telescope spell_suggest<cr>",    desc = "Change spelling" },
		{ "<leader>fd",  "<cmd>Telescope diagnostics<cr>",  desc = "Open diagnostics" },
		{ "<leader>fhl", "<cmd>Telescope help_tags<cr>",    desc = "Open help" },
		{ "<leader>fw",  "<cmd>Telescope grep_string<cr>",  desc = "Grep word" },
		{ "<leader>fW",  "<cmd>Telescope live_grep<cr>",    desc = "Live grep word" },
	},
	config = function ()

		require('telescope').setup{
			defaults = {
				layout_strategy='bottom_pane',
				layout_config = {
					height = 15,
				},
				sorting_strategy = "ascending",
				selection_caret = "❯ ",
				prompt_prefix = "❯ ",
				results_title = "",
				-- entry_prefix
				multi_icon = "┃",
				-- Only for ivy layout
				borderchars = {
					prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
					results = { " " },
					preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				},
				-- Only for dropdownm
				-- borderchars = {
				-- 	{ '─', '│', '─', '│', '┌', '┐', '┘', '└'},
				-- 	prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
				-- 	results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
				-- 	preview = { '─', '│', '─', '│', '┌', '┤', '┘', '└'},
				-- },
				preview = {
					hide_on_startup = true
				},
				-- Default configuration for telescope goes here:
				-- config_key = value,
				mappings = {
					i = {
						-- map actions.which_key to <C-h> (default: <C-/>)
						-- actions.which_key shows the mappings for your picker,
						-- e.g. git_{create, delete, ...}_branch for the git_branches picker
						["<C-h>"] = "which_key"
					}
				}
			},
			pickers = {
				find_files = { prompt_prefix = "find files❯ ", prompt_title = false },
				buffers = { prompt_prefix = "buffers❯ ", prompt_title = false },
				oldfiles = { prompt_prefix = "recent files❯ ", prompt_title = false },
				highlights = { prompt_prefix = "highlights❯ ", prompt_title = false },
				colorschemes = { prompt_prefix = "colorschemes❯ ", prompt_title = false },
				spell_suggest = { prompt_prefix = "spell❯ ", prompt_title = false },
				help_tags = { prompt_prefix = "help❯ ", prompt_title = false },
				diagnostics = { prompt_prefix = "diagnostics❯ ", prompt_title = false },
				grep_string = { prompt_prefix = "grep❯ ", prompt_title = false },
				live_grep = { prompt_prefix = "live grep❯ ", prompt_title = false },
				filetypes = { prompt_prefix = "filetypes❯ ", prompt_title = false },
			},
		}
	end
}
