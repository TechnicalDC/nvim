local nmap = function(lhs, rhs, desc)
	-- See `:h vim.keymap.set()`
	vim.keymap.set('n', lhs, rhs, { desc = desc })
end

local config = {
	options = {
		content_from_bottom = false,
	},
	window = {
		config = {
			-- split = "bottom",
			border = "single",
			height = 15,
			width = vim.o.columns,
		},
		prompt_prefix = "  ",
		prompt_caret = "▏"
	}
}

require('mini.pick').setup(config)
require('mini.extra').setup()

nmap("<leader>fb", "<cmd>lua MiniPick.builtin.buffers()<cr>", "Open buffers")
nmap("<leader>ff", "<cmd>lua MiniPick.builtin.files()<cr>", "Open files")
nmap("<leader>fhl", "<cmd>lua MiniPick.builtin.help()<cr>", "Open help")
nmap("<leader>fhi", "<cmd>lua MiniExtra.pickers.hl_groups()<cr>", "Open highlight group")
nmap("<leader>fd", "<cmd>lua MiniExtra.pickers.diagnostic()<cr>", "Open diagnostic")
nmap("<leader>fH", "<cmd>lua MiniExtra.pickers.hipatterns()<cr>", "Open hipatterns")
nmap("<leader>fo", "<cmd>lua MiniExtra.pickers.oldfiles()<cr>", "Open oldfiles")
nmap("<leader>fs", "<cmd>lua MiniExtra.pickers.spellsuggest()<cr>", "Open spellsuggest")
nmap("<leader>fw", "<cmd>lua MiniPick.builtin.grep()<cr>", "Grep word")
nmap("<leader>fW", "<cmd>lua MiniPick.builtin.grep_live()<cr>", "Live grep word")
nmap("<leader>fc", "<cmd>lua MiniExtra.pickers.colorschemes()<cr>", "Choose colorscheme")
nmap("<leader>ns", "<cmd>lua MiniPick.builtin.grep_live(nil,{ source = {cwd = '/home/dilip/orgfiles/'} })<cr>", "Search in notes")
