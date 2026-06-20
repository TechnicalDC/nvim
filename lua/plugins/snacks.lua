local headers = require("dc.headers")
-- Snacks is insistent about removing the tabline and statusline from the dashboard
vim.api.nvim_create_autocmd('User', {
	pattern = 'SnacksDashboardOpened',
	callback = function()
		vim.o.laststatus = 3
	end
})

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		{ "<leader>gg", function() require("snacks").lazygit() end, desc = "Lazygit" },
		{ "<leader>dn", function() require("snacks").notifier.hide() end, desc = "Dismiss All Notifications" },
		{ "<leader>sn",  function() require("snacks").notifier.show_history() end, desc = "Notification History" },
		{ "<leader>sb",  function() require("snacks").picker.buffers() end,      desc = "Open buffers" },
		{ "<leader>sk",  function() require("snacks").picker.keymaps() end,      desc = "Keymaps" },
		{ "<leader>sr",  function() require("snacks").picker.recent() end,      desc = "Open recent files" },
		{ "<leader>shi", function() require("snacks").picker.highlights() end,      desc = "Open highlights" },
		{ "<leader>sf",  function() require("snacks").picker.files() end,   desc = "Open files" },
		{ "<leader>sc",  function() require("snacks").picker.colorschemes() end, desc = "Change colorscheme" },
		{ "<leader>sd",  function() require("snacks").picker.diagnostics() end,  desc = "Open diagnostics" },
		{ "<leader>shl", function() require("snacks").picker.help() end,    desc = "Open help" },
		{ "<leader>sB", function() require("snacks").picker.grep_buffers() end, desc = "Grep Open Buffers" },
		{ "<leader>sW", function() require("snacks").picker.grep() end, desc = "Grep" },
		{ "<leader>sw", function() require("snacks").picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
		{ "<leader>sm", function() require("snacks").picker.marks() end, desc = "Marks" },
		{ "<leader>ss", function() require("snacks").picker.lsp_symbols() end, desc = "LSP Symbols" },
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
				},
			},
			formats = {
				key = function(item)
					return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
				end,
			},
			sections = {
				{ section = "header" },
				{ hidden = true, icon = " ", key = "f", desc = "find File", action = ":lua Snacks.dashboard.pick('files')" },
				{ hidden = true, icon = " ", key = "n", desc = "new File", action = ":ene | startinsert" },
				{ hidden = true, icon = " ", key = "s", desc = "session", action = ":lua require('mini.sessions').select()" },
				{ hidden = true, icon = " ", key = "b", desc = "browse", action = ":lua require('mini.files').open(vim.uv.cwd(), true)" },
				{ hidden = true, icon = " ", key = "c", desc = "config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
				{ hidden = true, icon = " ", key = "u", desc = "update", action = ":Lazy update" },
				{ hidden = true, icon = " ", key = "q", desc = "quit", action = ":qa" },
				{
					align = 'center',
					padding = 1,
					text = {
						{ ' [n]ew ', hl = 'Label' },
						{ ' [f]iles ', hl = 'DiagnosticInfo' },
						{ ' [b]rowse ', hl = '@constant' },
						{ ' [s]essions ', hl = 'Label' },
						{ ' [c]onfig ', hl = 'Keyword'},
						{ ' [u]pdate ', hl = 'DiagnosticInfo'},
						{ ' [q]uit ', hl = '@error'},
					},
				},
				{ title = "Recent Files", padding = 1 },
				{ section = "recent_files", limit = 9, padding = 1, indent = 2 },
				{ section = "startup" },
			},
		},
		explorer = { enabled = false },
		indent = {
			enabled = true,
			indent = { char = "┊" },
			scope = { char = "┊" },
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
