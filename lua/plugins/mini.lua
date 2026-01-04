return { 
	'nvim-mini/mini.nvim', 
	version = false, 
	config = function() 
		require('mini.ai').setup()
		require('mini.align').setup()
		require('mini.animate').setup()
		require('mini.bracketed').setup()
		require('mini.clue').setup()
		require('mini.diff').setup()
		require('mini.files').setup()
		require('mini.git').setup()
		require('mini.indentscope').setup()
		require('mini.icons').setup()
		require('mini.move').setup()
		require('mini.pairs').setup()
		require('mini.pick').setup()
		require('mini.sessions').setup()
		require('mini.splitjoin').setup()
		require('mini.starter').setup()
		require('mini.statusline').setup()
		require('mini.surround').setup()
		require('mini.visits').setup()
	end }
