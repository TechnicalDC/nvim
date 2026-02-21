return {
	'nvim-telescope/telescope.nvim', version = '*',
	dependencies = {
		'nvim-lua/plenary.nvim',
		"joaomsa/telescope-orgmode.nvim",
		-- optional but recommended
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	},
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
					height = 0.5,
				},
				sorting_strategy = "ascending",
				prompt_prefix = "❯ ",
				selection_caret = "❯ ",
				-- entry_prefix
				multi_icon = "┃",
				border = false,
				-- borderchars 
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
				-- Default configuration for builtin pickers goes here:
				-- picker_name = {
					--   picker_config_key = value,
					--   ...
					-- }
					-- Now the picker_config_key will be applied every time you call this
					-- builtin picker
				},
				extensions = {
					-- Your extension configuration goes here:
					-- extension_name = {
						--   extension_config_key = value,
						-- }
						-- please take a look at the readme of the extension you want to configure
					}
				}
				-- require('telescope').load_extension('orgmode')
			end
		}
