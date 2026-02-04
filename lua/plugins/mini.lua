return {
	'nvim-mini/mini.nvim',
	version = false,
	config = function()
		require("dc.config.pick")
		require("dc.config.clue")
		require("dc.config.diff")
		require("dc.config.files")
		require("dc.config.hipatterns")
		require("dc.config.icons")
		require("dc.config.indentscope")
		require("dc.config.misc")
		require("dc.config.move")
		require("dc.config.notify")
		require("dc.config.session")
		require("dc.config.splitjoin")
		require("dc.config.starter")
		require("dc.config.statusline")

		require('mini.ai').setup()
		require('mini.align').setup()
		require('mini.bracketed').setup()
		require('mini.git').setup()
		require('mini.pairs').setup()
		require('mini.operators').setup()
		require('mini.surround').setup()
		-- require('mini.tabline').setup()
		require('mini.visits').setup()
	end 
}
