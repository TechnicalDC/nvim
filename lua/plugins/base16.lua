return {
	"AvengeMedia/base46",
	lazy = true,
	opts = {},
	config = function()
		vim.cmd.colorscheme("dank-neovim")
		require("dc.highlights").solid()
	end
}
