local headers = require("dc.headers")
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		{ "<leader>sb",  function() require("snacks").picker.buffers() end,      desc = "Open buffers" },
		{ "<leader>sk",  function() require("snacks").picker.keymaps() end,      desc = "Keymaps" },
		{ "<leader>sr",  function() require("snacks").picker.recent() end,      desc = "Open recent files" },
		{ "<leader>shi", function() require("snacks").picker.highlights() end,      desc = "Open highlights" },
		{ "<leader>sf",  function() require("snacks").picker.files() end,   desc = "Open files" },
		{ "<leader>sc",  function() require("snacks").picker.colorschemes() end, desc = "Change colorscheme" },
		-- { "<leader>ft",  "<cmd>Telescope filetypes<cr>",    desc = "Change filetype" },
		-- { "<leader>fs",  "<cmd>Telescope spell_suggest<cr>",    desc = "Change spelling" },
		{ "<leader>sd",  function() require("snacks").picker.diagnostics() end,  desc = "Open diagnostics" },
		{ "<leader>shl", function() require("snacks").picker.help() end,    desc = "Open help" },
		{ "<leader>sB", function() require("snacks").picker.grep_buffers() end, desc = "Grep Open Buffers" },
		{ "<leader>sW", function() require("snacks").picker.grep() end, desc = "Grep" },
		{ "<leader>sw", function() require("snacks").picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
		{ "<leader>sm", function() require("snacks").picker.marks() end, desc = "Marks" },
		{ "gd", function() require("snacks").picker.lsp_definitions() end, desc = "Goto Definition" },
		{ "gD", function() require("snacks").picker.lsp_declarations() end, desc = "Goto Declaration" },
		{ "gr", function() require("snacks").picker.lsp_references() end, nowait = true, desc = "References" },
		{ "gI", function() require("snacks").picker.lsp_implementations() end, desc = "Goto Implementation" },
		{ "gy", function() require("snacks").picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
		{ "gai", function() require("snacks").picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
		{ "gao", function() require("snacks").picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
	},
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			preset = {
				header = headers.dc,
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{ icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			formats = {
				key = function(item)
					return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
				end,
			},
			sections = {
				{ section = "header" },
				{ title = "Bookmarks", padding = 1 },
				{ section = "keys", padding = 1, indent = 2 },
				{ title = "MRU", padding = 1 },
				{ section = "recent_files", limit = 8, padding = 1, indent = 2 },
				{ title = "Sessions", padding = 1 },
				{ section = "projects", padding = 1, indent = 2 },
			},
		},
		explorer = { enabled = false },
		indent = {
			enabled = true,
			indent = { char = "┊" }
		},
		input = { enabled = false },
		picker = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
}
