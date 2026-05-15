return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	enabled = false,
	---@type snacks.Config
	keys = {
		{ "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
		{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
		{ "<leader>fH", function() Snacks.picker.highlights() end, desc = "Highlights" },
		{ "<leader>fC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
		{ "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
		{ "<leader>fh", function() Snacks.picker.help() end, desc = "Help Pages" },
		{ "<leader>fB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
		{ "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
		{ '<leader>fR', function() Snacks.picker.registers() end, desc = "Registers" },
		{ '<leader>fs', function() Snacks.picker.search_history() end, desc = "Search History" },
		{ "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
		{ "<leader>fm", function() Snacks.picker.marks() end, desc = "Marks" },
	},
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		explorer = { enabled = false },
		indent = { enabled = false },
		input = { enabled = true },
		picker = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = false },
		scroll = { enabled = true },
		statuscolumn = { enabled = false },
		words = { enabled = true },
	},
}
