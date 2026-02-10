-- local opts = { noremap=true, silent=false }

return {
	"zk-org/zk-nvim",
	enabled = true,
	config = function()
		require("zk").setup({
			-- Can be "telescope", "fzf", "fzf_lua", "minipick", "snacks_picker",
			-- or select" (`vim.ui.select`).
			picker = "select",

			lsp = {
				-- `config` is passed to `vim.lsp.start(config)`
				config = {
					name = "zk",
					cmd = { "zk", "lsp" },
					filetypes = { "markdown" },
					-- on_attach = ...
					-- etc, see `:h vim.lsp.start()`
				},

				-- automatically attach buffers in a zk notebook that match the given filetypes
				auto_attach = {
					enabled = true,
				},
			},
		})

		-- Open the link under the caret.
		vim.api.nvim_set_keymap("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to file" })

		-- Open notes.
		vim.api.nvim_set_keymap("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", { desc = "Open notes" })
		-- Open notes associated with the selected tags.
		vim.api.nvim_set_keymap("n", "<leader>zt", "<Cmd>ZkTags<CR>", { desc = "Open notes with tag" })

		-- Search for the notes matching a given query.
		vim.api.nvim_set_keymap("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", { desc = "Find notes with matching query" })
		-- Search for the notes matching the current visual selection.
		vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", { desc = "Find notes for current selection" })

		-- Create a new note after asking for its title.
		-- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
		vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", { desc = "New note" })
		-- Create a new note in the same directory as the current buffer, using the current selection for title.
		vim.api.nvim_set_keymap("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", { desc = "New note from title" })
		-- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
		vim.api.nvim_set_keymap( "v", "<leader>znc",
			":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
			{ desc = "New note from content" })

		-- Open notes linking to the current buffer.
		vim.api.nvim_set_keymap("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", { desc = "Open backlinks" })
		-- Alternative for backlinks using pure LSP and showing the source context.
		--map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', { desc = "" })
		-- Open notes linked by the current buffer.
		vim.api.nvim_set_keymap("n", "<leader>zl", "<Cmd>ZkLinks<CR>", { desc = "Open links" })

		-- Preview a linked note.
		vim.api.nvim_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Preview note" })
		-- Open the code actions for a visual selection.
		vim.api.nvim_set_keymap("v", "<leader>za", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", { desc = "Code actions" })
	end
}
