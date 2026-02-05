return {
	'vimwiki/vimwiki',
	enabled = true,
	-- The keys that trigger the plugin
	keys = {
		"<leader>ww",
		"<leader>wt"
	},
	-- The configuration for the plugin
	init = function()
		vim.g.vimwiki_list = {
			{
				-- Here will be the path for your wiki
				path = "~/Notes/",
				-- The syntax for the wiki
				syntax = "markdown",
				ext = "md",
			},
		}
		-- vim.g.vimwiki_ext2syntax = { }
  end,
}
